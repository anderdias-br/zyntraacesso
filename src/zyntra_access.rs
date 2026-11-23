//! Product identity. Transport, password verification and UAC stay upstream.
use std::sync::Once;

pub const APP_NAME: &str = "ZyntraAcesso";
static INIT_IDENTITY: Once = Once::new();

pub fn init_identity() {
    INIT_IDENTITY.call_once(|| {
        *hbb_common::config::APP_NAME.write().unwrap() = APP_NAME.to_owned();
    });
}
