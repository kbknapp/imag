use clap::{Arg, App, ArgGroup, SubCommand};

use libimagentrytag::ui::{tag_add_arg, tag_remove_arg};

pub fn build_ui<'a>(app: App<'a, 'a>) -> App<'a, 'a> {
    app.arg(Arg::with_name("id")
                .long("id")
                .short("i")
                .takes_value(true)
                .required(true)
                .help("Use this entry"))

        .arg(tag_add_arg())
        .arg(tag_remove_arg())

       .subcommand(SubCommand::with_name("list")
                   .about("List tags (default)")
                   .version("0.1")
                   .arg(Arg::with_name("json")
                        .long("json")
                        .short("j")
                        .takes_value(false)
                        .required(false)
                        .help("List as JSON"))
                   .arg(Arg::with_name("linewise")
                        .long("linewise")
                        .short("l")
                        .takes_value(false)
                        .required(false)
                        .help("One tag per line"))
                   .arg(Arg::with_name("commasep")
                        .long("comma")
                        .short("c")
                        .takes_value(false)
                        .required(false)
                        .help("Commaseperated (default)"))
                   .arg(Arg::with_name("sep")
                        .long("sep")
                        .short("s")
                        .takes_value(true)
                        .required(false)
                        .help("Seperated by string"))

                   .group(ArgGroup::with_name("list-group")
                          .args(&[
                                "json",
                                "linewise",
                                "commasep",
                                "sep",
                          ])
                          .required(true))
                   )

}


