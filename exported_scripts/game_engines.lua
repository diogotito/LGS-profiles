--[[
A única coisa que sinto falta no G-Hub é a funcionalidade de G-Shift para ter mais atalhos.
Vou tentar replicar essa funcionalidade aqui neste script
]]

MEU_G_SHIFT = 6            -- N.º do botão com o ícone da mira que fica à frente do polegar
g_shift_ligado = false     -- Memoriza se este botão foi premido (true) ou largado (false)

function OnEvent(event, arg)
	-- Mostra o que está no event e no arg numa linha no painel de Output abaixo
	-- Quando event é "MOUSE_BUTTON_PRESSED" ou "MOUSE_BUTTON_RELEASED",
	-- arg é o nº do botão do rato premido ou largado
	OutputLogMessage("event = %s, arg = %s\n", event, arg);
	
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
		if arg == 3 then
			OutputLogMessage "  * Fechar Separador [Ctrl + W]\n"
			PlayMacro("* close tab")
		end
	end
end