use clap::Parser;
use rand::SeedableRng;
use rand::{rngs::OsRng, RngCore};
use rand_pcg::Pcg64;

#[derive(clap::Parser)]
struct Cli {
    #[command(subcommand)]
    type_: Type_,
    #[arg(short, long, default_value_t = 17)]
    len: usize,
}

#[derive(clap::Subcommand)]
enum Type_ {
    Alnum,
    Digit,
    Printable,
}

impl Type_ {
    const fn clamp_u8(&self) -> impl for<'a> Fn(&'a mut u8) {
        static ALNUM: &[u8] = b"0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        static DIGIT: &[u8] = b"0123456789";
        static NUM_PRINTABLE_ASCII: usize = '~' as usize - '!' as usize + 1;
        static PRINTABLE: [u8; NUM_PRINTABLE_ASCII] = {
            let mut ret = [0_u8; NUM_PRINTABLE_ASCII];
            let mut idx = 0;
            while idx < ret.len() {
                ret[idx] = '!' as u8 + idx as u8;
                idx += 1;
            }
            ret
        };
        fn clamp_u8_with(u: u8, list_of_u8_s: &[u8]) -> u8 {
            list_of_u8_s[u as usize * list_of_u8_s.len() / (u8::MAX as usize + 1)]
        }
        match self {
            Self::Alnum => |u: &mut u8| *u = clamp_u8_with(*u, ALNUM),
            Self::Digit => |u: &mut u8| *u = clamp_u8_with(*u, DIGIT),
            Self::Printable => |u: &mut u8| *u = clamp_u8_with(*u, &PRINTABLE),
        }
    }
}

fn main() {
    let cli = Cli::parse();
    let mut bytes = Vec::from_iter(std::iter::repeat_n(0, cli.len));
    let mut rng = Pcg64::seed_from_u64(OsRng.next_u64());
    rng.fill_bytes(&mut bytes);
    bytes.iter_mut().for_each(cli.type_.clamp_u8());
    println!("{}", unsafe { String::from_utf8_unchecked(bytes) });
}
