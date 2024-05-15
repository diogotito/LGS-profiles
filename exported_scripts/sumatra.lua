--[[
A única coisa que sinto falta no G-Hub é a funcionalidade de G-Shift para ter mais atalhos.
Vou tentar replicar essa funcionalidade aqui neste script
]]

MEU_G_SHIFT = 6
g_shift_ligado = false

function OnEvent(event, arg)
	OutputLogMessage("event = %s, arg = %s\n", event, arg);

	--[[
		Ok, mais uma coisa que por acaso o G-Hub tinha e o LGS não!
		Lá, nas macros, dava para programar ações para quando o botão associado à macro era
		premido, se mantinha premido e era largado.
		Agora quero carregar Esc quando o meu botão para "autoscroll" é largado
		para o Sumatra não continuar a scrollar
		(por acaso podia dar merge desta lógica com a do G-Shift)
	]]
	if event == "MOUSE_BUTTON_RELEASED" and arg == 6 then
		PressAndReleaseKey("escape")
	end
	
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
	
	if event == "MOUSE_BUTTON_PRESSED" then
		if g_shift_ligado then
			OutputLogMessage("\n >>>  ON  <<<\n\n")
			if arg == 11 or arg == 8 then
				OutputLogMessage	(" * 1 página")
				PlayMacro(" * 1 pagina")
			end
			if arg == 10 or arg == 7 then
				PlayMacro(" * 2 paginas")
			end
		else
			OutputLogMessage("LARGADO")
			if arg == 11 then
				PlayMacro("<C-S-Tab> Separador esq")
			end
			if arg == 10 then
				PlayMacro("<C-Tab> Separador dir")
			end
		end
	end
end