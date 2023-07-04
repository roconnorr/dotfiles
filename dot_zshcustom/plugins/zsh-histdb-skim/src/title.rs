use crate::environment::*;
use crate::location::Location;
use enum_map::enum_map;

pub fn generate_title(location: &Location) -> String {
    let extra_info = |theloc: &Location| -> String {
        return match theloc {
            Location::Session => get_current_session_id(),
            Location::Directory => get_current_dir(),
            Location::Machine => get_current_host(),
            _ => String::from(""),
        };
    }(&location);

    let location_map = enum_map! {
        Location::Session => "Session location history",
        Location::Directory => "Directory location history",
        Location::Machine => "Machine location history",
        Location::Everywhere => "Everywhere",
    };

    let header_map = enum_map! {
        Location::Session =>
" ┏━━━━━━━┱─────────┬────┬──────────┐
 ┃Session┃Directory│Host│Everywhere│ F5: Toggle group
━┛       ┗━━━━━━━━━┷━━━━┷━━━━━━━━━━┷━━━━━━━━━━━━━━━━━",
        Location::Directory =>
" ┌───────┲━━━━━━━━━┱────┬──────────┐
 │Session┃Directory┃Host│Everywhere│ F5: Toggle group
━┷━━━━━━━┛         ┗━━━━┷━━━━━━━━━━┷━━━━━━━━━━━━━━━━━",

        Location::Machine =>
" ┌───────┬─────────┲━━━━┱──────────┐
 │Session│Directory┃Host┃Everywhere│ F5: Toggle group
━┷━━━━━━━┷━━━━━━━━━┛    ┗━━━━━━━━━━┷━━━━━━━━━━━━━━━━━",

        Location::Everywhere =>
" ┌───────┬─────────┬────┲━━━━━━━━━━┓
 │Session│Directory│Host┃Everywhere┃ F5: Toggle group
━┷━━━━━━━┷━━━━━━━━━┷━━━━┛          ┗━━━━━━━━━━━━━━━━━",
    };

    let title = format!(
        "{} {}\n{}\n",
        &location_map[location.clone()],
        &extra_info,
        &header_map[location.clone()],
    );
    return title.to_string();
}
