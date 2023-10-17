#![no_std]          // use core rather than std
#![no_main]         // no start point
#![feature(panic_info_message)]

#[macro_use]
mod console;
mod sbi;
mod lang_items;     // our panic! macro package

use core::arch::global_asm;
global_asm!(include_str!("entry.asm"));     // embed the ams code as string


#[no_mangle]
pub fn rust_main() -> ! {
    clear_bss();
    println!("Hello rCore!");
    error!("Hello error!");
    warn!("Hello warn!");
    info!("Hello info!");
    debug!("Hello debug!");
    trace!("Hello trace!");
    panic!("Shutdown machine!");
}

fn clear_bss() {
    extern "C" {
        fn sbss();
        fn ebss();
    }
    (sbss as usize..ebss as usize).for_each(|a| {
        unsafe { (a as *mut u8).write_volatile(0) }
    });
}

// fn main() {
//     // println!("Hello, world!");
// }
