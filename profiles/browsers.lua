mouse.maps {
  [      SCROLL_LEFT]  = '^pageup',
--[AIM + SCROLL_LEFT]  = '^+pageup',
  [      SCROLL_RIGHT] = '^pagedown',
--[AIM + SCROLL_RIGHT] = '^+pagedown',
  [AIM + RIGHT]        = '^tab',
  [AIM + MIDDLE]       = '^w',
  [AIM + INDEX_UP]     = 'end',
  [AIM + INDEX_DOWN]   = 'home',
}


--[=[ Script original:
--[[
A única coisa que sinto falta no G-Hub é a funcionalidade de G-Shift para ter mais atalhos.
Vou tentar replicar essa funcionalidade aqui neste script
]]

MEU_G_SHIFT = 6            -- Aquele botão com o ícone da mira que fica à frente do polegar
g_shift_ligado = false

espera_rightclick = false

function OnEvent(event, arg)
	--OutputLogMessage("event = %s, arg = %s\n", event, arg);
	
	-- Ligar/Desligar G-Shift
	if arg == MEU_G_SHIFT then
		if event == "MOUSE_BUTTON_PRESSED" then
			g_shift_ligado = true
			return
		elseif event == "MOUSE_BUTTON_RELEASED" then
			g_shift_ligado = false
			return
		end
	end
	
	if g_shift_ligado and event == "MOUSE_BUTTON_PRESSED" then
		-- Faz com que qualquer botão na roda (MMB/Scr[LR]) feche o separador
		if arg == 3 then
			OutputLogMessage "\n    * Fechar separador    		    \t[Ctrl + W]\n\n"
			PressAndReleaseKey("escape")
			PressKey("lctrl")
			PressAndReleaseKey("w")
			ReleaseKey("lctrl")
		end
		if arg == 11 then
			OutputLogMessage "\n    * Mover para a esquerda    \t[Ctrl + Shfit + Left]\n\n"
			PressKey("lctrl", "lshift")
			PressAndReleaseKey("pageup")
			ReleaseKey("lctrl", "lshift")
		end	
		if arg == 10 then
			OutputLogMessage "\n    * Mover para a direita         \t[Ctrl + Shift + Right]\n\n"
			PressKey("lctrl", "lshift")
			PressAndReleaseKey("pagedown")
			ReleaseKey("lctrl", "lshift")
		end
		-- Faz com que RMB alterne entre os dois últimos separadores vistos (no Firefox)
		if arg == 2 then
			OutputLogMessage "\n    * Alternar entre 2 separadores \t[Ctrl + Tab]\n\n"
			PressKey("lctrl")
			PressAndReleaseKey("tab")
			ReleaseKey("lctrl")
			espera_rightclick = true  -- O RMB vai abrir um menu de contexto quando for largado
		end
		if arg == 7 then
			OutputLogMessage "\n    * Vai para o fim da pagina     \t[End]\n\n"
			PressAndReleaseKey("escape", "end")
		end
		if arg == 8 then
			OutputLogMessage "\n    * Vai para o inicio da pagina  \t[Home]\n\n"
			PressAndReleaseKey("escape", "home")
		end
	end
	
	if espera_rightclick and event == "MOUSE_BUTTON_RELEASED" and arg == 2 then
		-- Macros com sequências on release também haviam no G-Hub
		espera_rightclick = false
		PressAndReleaseKey("escape")  -- Fecha o menu de contexto aberto pelo RMB
	end

	-- Scroll Left e Scroll Right, fora do G-Shift
	if event == "MOUSE_BUTTON_PRESSED" and not g_shift_ligado then
		if arg == 11 then
			PressKey("lctrl")
			PressAndReleaseKey("pageup")
			ReleaseKey("lctrl")
		end
		if arg == 10 then
			PressKey("lctrl")
			PressAndReleaseKey("pagedown")
			ReleaseKey("lctrl")
		end
	end
end
--]=]
