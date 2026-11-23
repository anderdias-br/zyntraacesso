import fs from 'node:fs';
import crypto from 'node:crypto';
import { brotliDecompressSync } from 'node:zlib';

const input = process.argv[2];
if (!input) throw new Error('Informe o instalador a conferir.');
const image = fs.readFileSync(input);
const marker = Buffer.from('rustdesk');
const expectedLogo = '5b83b5dd33706ed48fb4c765ee7a34fddfa0e18baef275a5dc761c7cc3319661';

function isWindowsX64(bytes) {
  if (bytes.length < 64 || bytes.toString('ascii', 0, 2) !== 'MZ') return false;
  const pe = bytes.readUInt32LE(60);
  return pe + 6 < bytes.length && bytes.toString('ascii', pe, pe + 4) === 'PE\0\0'
    && bytes.readUInt16LE(pe + 4) === 0x8664;
}

function parsePayload(start) {
  let at = start + marker.length;
  const files = new Map();
  let total = 0;
  while (at + 8 < image.length) {
    if (image.subarray(at, at + 8).equals(marker)) {
      const executable = image.subarray(at + 8, at + 80).toString('utf8');
      if (!/^\.[\\/]ZyntraAcesso\.exe/.test(executable)) return null;
      return { files, bytes: at - start, total };
    }
    const length = image.readUInt32BE(at);
    at += 4;
    if (length < 3 || length > 1024 || at + length + 4 >= image.length) return null;
    const name = image.subarray(at, at + length).toString('utf8').replaceAll('\\', '/');
    if (!name.startsWith('./') || name.split('/').includes('..') || /[:\0]/.test(name)) return null;
    at += length;
    const compressedLength = image.readUInt32BE(at);
    at += 4;
    if (compressedLength < 1 || at + compressedLength + 32 > image.length) return null;
    const compressed = image.subarray(at, at + compressedLength);
    at += compressedLength;
    const md5 = image.subarray(at, at + 32).toString('ascii');
    at += 32;
    if (!/^[a-f0-9]{32}$/.test(md5)) return null;
    const normalized = name.slice(2).toLowerCase();
    if (files.has(normalized)) throw new Error('Arquivo duplicado no pacote.');
    const bytes = brotliDecompressSync(compressed, { maxOutputLength: 128 * 1024 * 1024 });
    if (crypto.createHash('md5').update(bytes).digest('hex') !== md5) {
      throw new Error('O conteúdo do pacote não passou na conferência de integridade.');
    }
    total += bytes.length;
    if (total > 512 * 1024 * 1024 || files.size > 5000) throw new Error('Pacote fora dos limites esperados.');
    files.set(normalized, bytes);
  }
  return null;
}

if (!isWindowsX64(image)) throw new Error('O instalador não é um executável Windows x64.');
let payload;
let at = image.indexOf(marker);
while (at !== -1) {
  payload = parsePayload(at);
  if (payload?.files.has('zyntraacesso.exe')) break;
  at = image.indexOf(marker, at + 8);
}
if (!payload) throw new Error('O pacote ZyntraAcesso não foi encontrado.');

const executable = payload.files.get('zyntraacesso.exe');
const core = payload.files.get('librustdesk.dll');
if (!executable || !core || !isWindowsX64(executable) || !isWindowsX64(core)) {
  throw new Error('O aplicativo nativo ou seu motor está ausente/incompatível.');
}
if (!core.includes(Buffer.from('ZyntraAcesso'))) throw new Error('A identidade do motor não é ZyntraAcesso.');
const logo = payload.files.get('data/flutter_assets/assets/zyntra-mark.png');
if (!logo || crypto.createHash('sha256').update(logo).digest('hex') !== expectedLogo) {
  throw new Error('A logo oficial não está presente no aplicativo.');
}
if (!payload.files.has('licence.txt')) throw new Error('A licença da base não está no pacote.');

process.stdout.write(`${JSON.stringify({
  product: 'ZyntraAcesso',
  installerSha256: crypto.createHash('sha256').update(image).digest('hex'),
  installerBytes: image.length,
  files: payload.files.size,
  unpackedBytes: payload.total,
  windowsX64: true,
  zyntraIdentity: true,
  officialLogo: true,
  upstreamLicenseIncluded: true,
  binariesExecuted: false,
}, null, 2)}\n`);
