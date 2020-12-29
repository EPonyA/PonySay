import term
import term.ui as tui
import animations as ani
import rand

struct App {
mut:
		tui      &tui.Context = 0
		redraw   bool
		tick i8
}

fn init(x voidptr) {
		mut a := &App(x)
		a.redraw = true
}

fn event(e &tui.Event, x voidptr) {
		mut app := &App(x)
		app.redraw = true
}

fn frame(x voidptr) {
		mut app := &App(x)
		if !app.redraw { return }
		app.tui.clear()

		// Pony
		pony_state := ani.Pony_State {
				tick: app.tick + 1
				head: ani.anim_head(app.tick+1)
		}
		for i, s in pony_state.head{
				app.tui.draw_text(s.offset, i + 2, s.runes)
		}

		// Say
		sayings := [
				'hello'
				'world'
		]
		app.tui.draw_text(app.tui.window_width / 2, 0, sayings[rand.intn(sayings.len)])

		app.tui.reset()
		app.tui.flush()
}

fn main() {
		mut app := &App{}
		app.tui = tui.init(
				user_data: app,
				init_fn:  init,
				event_fn: event,
				frame_fn: frame

				hide_cursor: true
				frame_rate: 60
		)

		app.tui.run()
}
