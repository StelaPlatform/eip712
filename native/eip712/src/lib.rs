use eip_712::{hash_structured_data, EIP712};
use rustler::{Encoder, Env, NifResult, Term};
use serde_json::from_str;

mod atoms {
    rustler::atoms! {
      ok,
      error
    }
}

#[rustler::nif]
pub fn encode<'a>(env: Env<'a>, message: String) -> NifResult<Term<'a>> {
    let typed_data = match from_str::<EIP712>(&message) {
        Ok(data) => data,
        Err(error) => return Ok((atoms::error(), error.to_string()).encode(env)),
    };

    return match hash_structured_data(typed_data.clone()) {
        Ok(hash) => Ok((atoms::ok(), format!("{hash:#x}")).encode(env)),
        Err(error) => Ok((atoms::error(), error.to_string()).encode(env)),
    };
}

rustler::init!("Elixir.Eip712", [encode]);
