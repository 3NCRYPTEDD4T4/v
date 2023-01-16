local a = game:GetService("Workspace")
local b = game:GetService("UserInputService")
local c = game:GetService("RunService")
local d = game:GetService("HttpService")
local e = game:GetService("Players")
local f = game:GetService("Stats")
local g = {
    drawings = {},
    hidden = {},
    connections = {},
    pointers = {},
    began = {},
    ended = {},
    changed = {},
    folders = {
        main = "vision",
        configs = "vision/configs"
    },
    shared = {
        initialized = false,
        fps = 0,
        ping = 0
    }
}
if not isfolder(g.folders.main) then
    makefolder(g.folders.main)
end
if not isfolder(g.folders.configs) then
    makefolder(g.folders.configs)
end
local h = {}
local i = {}
local j = {}
local k = {
    accent = Color3.fromRGB(50, 100, 255),
    light_contrast = Color3.fromRGB(30, 30, 30),
    dark_contrast = Color3.fromRGB(20, 20, 20),
    outline = Color3.fromRGB(0, 0, 0),
    inline = Color3.fromRGB(50, 50, 50),
    textcolor = Color3.fromRGB(255, 255, 255),
    textborder = Color3.fromRGB(0, 0, 0),
    cursoroutline = Color3.fromRGB(10, 10, 10),
    font = 2,
    textsize = 13
}
do
    function h:Size(l, m, n, o, p)
        if p then
            local q = l * p.Size.x + m;
            local r = n * p.Size.y + o;
            return Vector2.new(q, r)
        else
            local s, t = a.CurrentCamera.ViewportSize.x, a.CurrentCamera.ViewportSize.y;
            local q = l * s + m;
            local r = n * t + o;
            return Vector2.new(q, r)
        end
    end
    function h:Position(l, m, n, o, p)
        if p then
            local q = p.Position.x + l * p.Size.x + m;
            local r = p.Position.y + n * p.Size.y + o;
            return Vector2.new(q, r)
        else
            local s, t = a.CurrentCamera.ViewportSize.x, a.CurrentCamera.ViewportSize.y;
            local q = l * s + m;
            local r = n * t + o;
            return Vector2.new(q, r)
        end
    end
    function h:Create(u, v, w, x)
        local u = u or "Frame"
        local v = v or {Vector2.new(0, 0)}
        local w = w or {}
        local y = false;
        local p = nil;
        if u == "Frame" or u == "frame" then
            local z = Drawing.new("Square")
            z.Visible = true;
            z.Filled = true;
            z.Thickness = 0;
            z.Color = Color3.fromRGB(255, 255, 255)
            z.Size = Vector2.new(100, 100)
            z.Position = Vector2.new(0, 0)
            z.ZIndex = 50;
            z.Transparency = g.shared.initialized and 1 or 0;
            p = z
        elseif u == "TextLabel" or u == "textlabel" then
            local A = Drawing.new("Text")
            A.Font = 3;
            A.Visible = true;
            A.Outline = true;
            A.Center = false;
            A.Color = Color3.fromRGB(255, 255, 255)
            A.ZIndex = 50;
            A.Transparency = g.shared.initialized and 1 or 0;
            p = A
        elseif u == "Triangle" or u == "triangle" then
            local z = Drawing.new("Triangle")
            z.Visible = true;
            z.Filled = true;
            z.Thickness = 0;
            z.Color = Color3.fromRGB(255, 255, 255)
            z.ZIndex = 50;
            z.Transparency = g.shared.initialized and 1 or 0;
            p = z
        elseif u == "Image" or u == "image" then
            local B = Drawing.new("Image")
            B.Size = Vector2.new(12, 19)
            B.Position = Vector2.new(0, 0)
            B.Visible = true;
            B.ZIndex = 50;
            B.Transparency = g.shared.initialized and 1 or 0;
            p = B
        elseif u == "Circle" or u == "circle" then
            local C = Drawing.new("Circle")
            C.Visible = false;
            C.Color = Color3.fromRGB(255, 0, 0)
            C.Thickness = 1;
            C.NumSides = 30;
            C.Filled = true;
            C.Transparency = 1;
            C.ZIndex = 50;
            C.Radius = 50;
            C.Transparency = g.shared.initialized and 1 or 0;
            p = C
        elseif u == "Quad" or u == "quad" then
            local D = Drawing.new("Quad")
            D.Visible = false;
            D.Color = Color3.fromRGB(255, 255, 255)
            D.Thickness = 1.5;
            D.Transparency = 1;
            D.ZIndex = 50;
            D.Filled = false;
            D.Transparency = g.shared.initialized and 1 or 0;
            p = D
        elseif u == "Line" or u == "line" then
            local E = Drawing.new("Line")
            E.Visible = false;
            E.Color = Color3.fromRGB(255, 255, 255)
            E.Thickness = 1.5;
            E.Transparency = 1;
            E.Thickness = 1.5;
            E.ZIndex = 50;
            E.Transparency = g.shared.initialized and 1 or 0;
            p = E
        end
        if p then
            for F, G in pairs(w) do
                if F == "Hidden" or F == "hidden" then
                    y = true
                else
                    if g.shared.initialized then
                        p[F] = G
                    else
                        if F ~= "Transparency" then
                            p[F] = G
                        end
                    end
                end
            end
            if not y then
                g.drawings[#g.drawings + 1] = {p, v, w["Transparency"] or 1}
            else
                g.hidden[#g.hidden + 1] = {p}
            end
            if x then
                x[#x + 1] = p
            end
            return p
        end
    end
    function h:UpdateOffset(p, v)
        for F, G in pairs(g.drawings) do
            if G[1] == p then
                G[2] = v
            end
        end
    end
    function h:UpdateTransparency(p, H)
        for F, G in pairs(g.drawings) do
            if G[1] == p then
                G[3] = H
            end
        end
    end
    function h:Remove(p, I)
        local J = 0;
        for F, G in pairs(I and g.hidden or g.drawings) do
            if G[1] == p then
                J = F;
                if I then
                    G[1] = nil
                else
                    G[2] = nil;
                    G[1] = nil
                end
            end
        end
        table.remove(I and g.hidden or g.drawings, J)
        p:Remove()
    end
    function h:GetSubPrefix(K)
        local K = tostring(K):gsub(" ", "")
        local L = ""
        if #K == 2 then
            local M = string.sub(K, #K, #K + 1)
            L = M == "1" and "st" or M == "2" and "nd" or M == "3" and "rd" or "th"
        end
        return L
    end
    function h:Connection(N, O)
        local P = N:Connect(O)
        g.connections[#g.connections + 1] = P;
        return P
    end
    function h:Disconnect(P)
        for F, G in pairs(g.connections) do
            if G == P then
                g.connections[F] = nil;
                G:Disconnect()
            end
        end
    end
    function h:MouseLocation()
        return b:GetMouseLocation()
    end
    function h:MouseOverDrawing(Q, R)
        local R = R or {}
        local Q = {(Q[1] or 0) + (R[1] or 0), (Q[2] or 0) + (R[2] or 0), (Q[3] or 0) + (R[3] or 0),
                   (Q[4] or 0) + (R[4] or 0)}
        local S = h:MouseLocation()
        return S.x >= Q[1] and S.x <= Q[1] + Q[3] - Q[1] and (S.y >= Q[2] and S.y <= Q[2] + Q[4] - Q[2])
    end
    function h:GetTextBounds(A, T, U)
        local V = Vector2.new(0, 0)
        local W = h:Create("TextLabel", {Vector2.new(0, 0)}, {
            Text = A,
            Size = T,
            Font = U,
            Hidden = true
        })
        V = W.TextBounds;
        h:Remove(W, true)
        return V
    end
    function h:GetScreenSize()
        return a.CurrentCamera.ViewportSize
    end
    function h:LoadImage(p, X, Y)
        local Z;
        if isfile(g.folders.assets .. "/" .. X .. ".png") then
            Z = readfile(g.folders.assets .. "/" .. X .. ".png")
        else
            if Y then
                Z = game:HttpGet(Y)
                writefile(g.folders.assets .. "/" .. X .. ".png", Z)
            else
                return
            end
        end
        if Z and p then
            p.Data = Z
        end
    end
    function h:Lerp(p, _, a0)
        local a1 = 0;
        local a2 = {}
        local P;
        for F, G in pairs(_) do
            a2[F] = p[F]
        end
        local function a3()
            for F, G in pairs(_) do
                p[F] = (G - a2[F]) * a1 / a0 + a2[F]
            end
        end
        P = c.RenderStepped:Connect(function(a4)
            if a1 < a0 then
                a1 = a1 + a4;
                a3()
            else
                P:Disconnect()
            end
        end)
    end
    function h:Combine(a5, a6)
        local a7 = {}
        for F, G in pairs(a5) do
            a7[F] = G
        end
        local a8 = #a7;
        for a9, q in pairs(a6) do
            a7[a9 + a8] = q
        end
        return a7
    end
end
do
    g.__index = g;
    i.__index = i;
    j.__index = j;
    function g:New(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "UI Title"
        local ac = aa.size or aa.Size or Vector2.new(504, 604)
        local ad = aa.accent or aa.Accent or aa.color or aa.Color or k.accent;
        k.accent = ad;
        local ae = {
            pages = {},
            isVisible = false,
            uibind = getgenv().VisionSettings.uiKeybind,
            currentPage = nil,
            fading = false,
            dragging = false,
            drag = Vector2.new(0, 0),
            currentContent = {
                frame = nil,
                dropdown = nil,
                multibox = nil,
                colorpicker = nil,
                keybind = nil
            }
        }
        local af = h:Create("Frame", {Vector2.new(0, 0)}, {
            Size = h:Size(0, ac.X, 0, ac.Y),
            Position = h:Position(0.5, -(ac.X / 2), 0.5, -(ac.Y / 2)),
            Color = k.outline
        })
        ae["main_frame"] = af;
        local ag = h:Create("Frame", {Vector2.new(1, 1), af}, {
            Size = h:Size(1, -2, 1, -2, af),
            Position = h:Position(0, 1, 0, 1, af),
            Color = k.accent
        })
        local ah = h:Create("Frame", {Vector2.new(1, 1), ag}, {
            Size = h:Size(1, -2, 1, -2, ag),
            Position = h:Position(0, 1, 0, 1, ag),
            Color = k.light_contrast
        })
        local ai = h:Create("TextLabel", {Vector2.new(4, 2), ah}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 4, 0, 2, ah)
        })
        local aj = h:Create("Frame", {Vector2.new(4, 18), ah}, {
            Size = h:Size(1, -8, 1, -22, ah),
            Position = h:Position(0, 4, 0, 18, ah),
            Color = k.inline
        })
        local ak = h:Create("Frame", {Vector2.new(1, 1), aj}, {
            Size = h:Size(1, -2, 1, -2, aj),
            Position = h:Position(0, 1, 0, 1, aj),
            Color = k.outline
        })
        local al = h:Create("Frame", {Vector2.new(1, 1), ak}, {
            Size = h:Size(1, -2, 1, -2, ak),
            Position = h:Position(0, 1, 0, 1, ak),
            Color = k.dark_contrast
        })
        ae["back_frame"] = al;
        local am = h:Create("Frame", {Vector2.new(4, 24), al}, {
            Size = h:Size(1, -8, 1, -28, al),
            Position = h:Position(0, 4, 0, 24, al),
            Color = k.outline
        })
        local an = h:Create("Frame", {Vector2.new(1, 1), am}, {
            Size = h:Size(1, -2, 1, -2, am),
            Position = h:Position(0, 1, 0, 1, am),
            Color = k.inline
        })
        local ao = h:Create("Frame", {Vector2.new(1, 1), an}, {
            Size = h:Size(1, -2, 1, -2, an),
            Position = h:Position(0, 1, 0, 1, an),
            Color = k.light_contrast
        })
        ae["tab_frame"] = ao;
        function ae:GetConfig()
            local ap = {}
            for F, G in pairs(g.pointers) do
                if typeof(G:Get()) == "table" and G:Get().Transparency then
                    local aq, ar, as = G:Get().Color:ToHSV()
                    ap[F] = {
                        Color = {aq, ar, as},
                        Transparency = G:Get().Transparency
                    }
                else
                    ap[F] = G:Get()
                end
            end
            return game:GetService("HttpService"):JSONEncode(ap)
        end
        function ae:LoadConfig(ap)
            local ap = d:JSONDecode(ap)
            for F, G in pairs(ap) do
                if g.pointers[F] then
                    g.pointers[F]:Set(G)
                end
            end
        end
        function ae:Move(at)
            for F, G in pairs(g.drawings) do
                if G[2][2] then
                    G[1].Position = h:Position(0, G[2][1].X, 0, G[2][1].Y, G[2][2])
                else
                    G[1].Position = h:Position(0, at.X, 0, at.Y)
                end
            end
        end
        function ae:CloseContent()
            if ae.currentContent.dropdown and ae.currentContent.dropdown.open then
                local au = ae.currentContent.dropdown;
                au.open = not au.open;
                h:LoadImage(au.dropdown_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                for F, G in pairs(au.holder.drawings) do
                    h:Remove(G)
                end
                au.holder.drawings = {}
                au.holder.buttons = {}
                au.holder.inline = nil;
                ae.currentContent.frame = nil;
                ae.currentContent.dropdown = nil
            elseif ae.currentContent.multibox and ae.currentContent.multibox.open then
                local av = ae.currentContent.multibox;
                av.open = not av.open;
                h:LoadImage(av.multibox_image, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                for F, G in pairs(av.holder.drawings) do
                    h:Remove(G)
                end
                av.holder.drawings = {}
                av.holder.buttons = {}
                av.holder.inline = nil;
                ae.currentContent.frame = nil;
                ae.currentContent.multibox = nil
            elseif ae.currentContent.colorpicker and ae.currentContent.colorpicker.open then
                local aw = ae.currentContent.colorpicker;
                aw.open = not aw.open;
                for F, G in pairs(aw.holder.drawings) do
                    h:Remove(G)
                end
                aw.holder.drawings = {}
                ae.currentContent.frame = nil;
                ae.currentContent.colorpicker = nil
            elseif ae.currentContent.keybind and ae.currentContent.keybind.open then
                local ax = ae.currentContent.keybind.modemenu;
                ae.currentContent.keybind.open = not ae.currentContent.keybind.open;
                for F, G in pairs(ax.drawings) do
                    h:Remove(G)
                end
                ax.drawings = {}
                ax.buttons = {}
                ax.frame = nil;
                ae.currentContent.frame = nil;
                ae.currentContent.keybind = nil
            end
        end
        function ae:IsOverContent()
            local ay = false;
            if ae.currentContent.frame and
                h:MouseOverDrawing({ae.currentContent.frame.Position.X, ae.currentContent.frame.Position.Y,
                                    ae.currentContent.frame.Position.X + ae.currentContent.frame.Size.X,
                                    ae.currentContent.frame.Position.Y + ae.currentContent.frame.Size.Y}) then
                ay = true
            end
            return ay
        end
        function ae:Unload()
            for F, G in pairs(g.connections) do
                G:Disconnect()
                G = nil
            end
            for F, G in next, g.hidden do
                coroutine.wrap(function()
                    if G[1] and G[1].Remove and G[1].__OBJECT_EXISTS then
                        local p = G[1]
                        G[1] = nil;
                        G = nil;
                        p:Remove()
                    end
                end)()
            end
            for F, G in pairs(g.drawings) do
                coroutine.wrap(function()
                    if G[1].__OBJECT_EXISTS then
                        local p = G[1]
                        G[2] = nil;
                        G[1] = nil;
                        G = nil;
                        p:Remove()
                    end
                end)()
            end
            for F, G in pairs(g.began) do
                G = nil
            end
            for F, G in pairs(g.ended) do
                G = nil
            end
            for F, G in pairs(g.changed) do
                G = nil
            end
            g.drawings = nil;
            g.hidden = nil;
            g.connections = nil;
            g.began = nil;
            g.ended = nil;
            g.changed = nil;
            b.MouseIconEnabled = true
        end
        function ae:Watermark(aa)
            ae.watermark = {
                visible = false
            }
            local aa = aa or {}
            local az = aa.name or aa.Name or aa.title or aa.Title or
                           string.format("$$ vision || uid : %u || ping : %u || fps : %u", 1, 100, 200)
            local aA = h:GetTextBounds(az, k.textsize, k.font)
            local aB = h:Create("Frame", {Vector2.new(100, 38 / 2 - 10)}, {
                Size = h:Size(0, aA.X + 20, 0, 21),
                Position = h:Position(0, 100, 0, 38 / 2 - 10),
                Hidden = true,
                ZIndex = 60,
                Color = k.outline,
                Visible = ae.watermark.visible
            })
            ae.watermark.outline = aB;
            local aC = h:Create("Frame", {Vector2.new(1, 1), aB}, {
                Size = h:Size(1, -2, 1, -2, aB),
                Position = h:Position(0, 1, 0, 1, aB),
                Hidden = true,
                ZIndex = 60,
                Color = k.inline,
                Visible = ae.watermark.visible
            })
            local aD = h:Create("Frame", {Vector2.new(1, 1), aC}, {
                Size = h:Size(1, -2, 1, -2, aC),
                Position = h:Position(0, 1, 0, 1, aC),
                Hidden = true,
                ZIndex = 60,
                Color = k.light_contrast,
                Visible = ae.watermark.visible
            })
            local aE = h:Create("Frame", {Vector2.new(0, 0), aD}, {
                Size = h:Size(1, 0, 0, 1, aD),
                Position = h:Position(0, 0, 0, 0, aD),
                Hidden = true,
                ZIndex = 60,
                Color = k.accent,
                Visible = ae.watermark.visible
            })
            local aF = h:Create("TextLabel", {Vector2.new(2 + 6, 4), aB}, {
                Text = string.format("vision - fps : %u - uid : %u", 35, 2),
                Size = k.textsize,
                Font = k.font,
                Color = k.textcolor,
                OutlineColor = k.textborder,
                Hidden = true,
                ZIndex = 60,
                Position = h:Position(0, 2 + 6, 0, 4, aB),
                Visible = ae.watermark.visible
            })
            function ae.watermark:UpdateSize()
                aB.Size = h:Size(0, aF.TextBounds.X + 4 + 6 * 2, 0, 21)
                aC.Size = h:Size(1, -2, 1, -2, aB)
                aD.Size = h:Size(1, -2, 1, -2, aC)
                aE.Size = h:Size(1, 0, 0, 1, aD)
            end
            function ae.watermark:Visibility()
                aB.Visible = ae.watermark.visible;
                aC.Visible = ae.watermark.visible;
                aD.Visible = ae.watermark.visible;
                aE.Visible = ae.watermark.visible;
                aF.Visible = ae.watermark.visible
            end
            function ae.watermark:Update(aG, aH)
                if aG == "Visible" then
                    ae.watermark.visible = aH;
                    ae.watermark:Visibility()
                end
            end
            h:Connection(c.RenderStepped, function(aI)
                g.shared.fps = math.round(1 / aI)
                g.shared.ping = tonumber(
                    string.split(f.Network.ServerStatsItem["Data Ping"]:GetValueString(), " ")[1] .. "")
            end)
            aF.Text = string.format("$$ vision || uid : %u || ping : %i || fps : %u", 1, tostring(g.shared.ping),
                g.shared.fps)
            ae.watermark:UpdateSize()
            spawn(function()
                while wait(0.1) do
                    aF.Text = string.format("$$ vision || uid : %u || ping : %i || fps : %u", 1,
                        tostring(g.shared.ping), g.shared.fps)
                    ae.watermark:UpdateSize()
                end
            end)
            return ae.watermark
        end
        function ae:KeybindsList(aa)
            ae.keybindslist = {
                visible = false,
                keybinds = {}
            }
            local aa = aa or {}
            local aJ = h:Create("Frame", {Vector2.new(10, h:GetScreenSize().Y / 2 - 200)}, {
                Size = h:Size(0, 150, 0, 22),
                Position = h:Position(0, 10, 0.4, 0),
                Hidden = true,
                ZIndex = 55,
                Color = k.outline,
                Visible = ae.keybindslist.visible
            })
            ae.keybindslist.outline = aJ;
            local aK = h:Create("Frame", {Vector2.new(1, 1), aJ}, {
                Size = h:Size(1, -2, 1, -2, aJ),
                Position = h:Position(0, 1, 0, 1, aJ),
                Hidden = true,
                ZIndex = 55,
                Color = k.inline,
                Visible = ae.keybindslist.visible
            })
            local aL = h:Create("Frame", {Vector2.new(1, 1), aK}, {
                Size = h:Size(1, -2, 1, -2, aK),
                Position = h:Position(0, 1, 0, 1, aK),
                Hidden = true,
                ZIndex = 55,
                Color = k.light_contrast,
                Visible = ae.keybindslist.visible
            })
            local aM = h:Create("Frame", {Vector2.new(0, 0), aL}, {
                Size = h:Size(1, 0, 0, 1, aL),
                Position = h:Position(0, 0, 0, 0, aL),
                Hidden = true,
                ZIndex = 55,
                Color = k.accent,
                Visible = ae.keybindslist.visible
            })
            local aN = h:Create("TextLabel", {Vector2.new(aJ.Size.X / 2, 4), aJ}, {
                Text = "- Keybinds -",
                Size = k.textsize,
                Font = k.font,
                Color = k.textcolor,
                OutlineColor = k.textborder,
                Center = true,
                Hidden = true,
                ZIndex = 55,
                Position = h:Position(0.5, 0, 0, 5, aJ),
                Visible = ae.keybindslist.visible
            })
            function ae.keybindslist:Resort()
                local aO = 0;
                for F, G in pairs(ae.keybindslist.keybinds) do
                    G:Move(0 + aO * 17)
                    aO = aO + 1
                end
            end
            function ae.keybindslist:Add(aP, aQ)
                if aP and aQ and not ae.keybindslist.keybinds[aP] then
                    local aR = {}
                    local aS = h:Create("Frame", {Vector2.new(0, aJ.Size.Y - 1), aJ}, {
                        Size = h:Size(1, 0, 0, 18, aJ),
                        Position = h:Position(0, 0, 1, -1, aJ),
                        Hidden = true,
                        ZIndex = 55,
                        Color = k.outline,
                        Visible = ae.keybindslist.visible
                    })
                    local aT = h:Create("Frame", {Vector2.new(1, 1), aS}, {
                        Size = h:Size(1, -2, 1, -2, aS),
                        Position = h:Position(0, 1, 0, 1, aS),
                        Hidden = true,
                        ZIndex = 55,
                        Color = k.inline,
                        Visible = ae.keybindslist.visible
                    })
                    local aU = h:Create("Frame", {Vector2.new(1, 1), aT}, {
                        Size = h:Size(1, -2, 1, -2, aT),
                        Position = h:Position(0, 1, 0, 1, aT),
                        Hidden = true,
                        ZIndex = 55,
                        Color = k.dark_contrast,
                        Visible = ae.keybindslist.visible
                    })
                    local aV = h:Create("TextLabel", {Vector2.new(4, 3), aS}, {
                        Text = aP,
                        Size = k.textsize,
                        Font = k.font,
                        Color = k.textcolor,
                        OutlineColor = k.textborder,
                        Center = false,
                        Hidden = true,
                        ZIndex = 55,
                        Position = h:Position(0, 4, 0, 3, aS),
                        Visible = ae.keybindslist.visible
                    })
                    local aW = h:Create("TextLabel", {Vector2.new(
                        aS.Size.X - 4 - h:GetTextBounds(aP, k.textsize, k.font).X, 3), aS}, {
                        Text = "[" .. aQ .. "]",
                        Size = k.textsize,
                        Font = k.font,
                        Color = k.textcolor,
                        OutlineColor = k.textborder,
                        Hidden = true,
                        ZIndex = 55,
                        Position = h:Position(1, -4 - h:GetTextBounds(aP, k.textsize, k.font).X, 0, 3, aS),
                        Visible = ae.keybindslist.visible
                    })
                    function aR:Move(aX)
                        aS.Position = h:Position(0, 0, 1, -1 + aX, aJ)
                        aT.Position = h:Position(0, 1, 0, 1, aS)
                        aU.Position = h:Position(0, 1, 0, 1, aT)
                        aV.Position = h:Position(0, 4, 0, 3, aS)
                        aW.Position = h:Position(1, -4 - aW.TextBounds.X, 0, 3, aS)
                    end
                    function aR:Remove()
                        h:Remove(aS, true)
                        h:Remove(aT, true)
                        h:Remove(aU, true)
                        h:Remove(aV, true)
                        h:Remove(aW, true)
                        ae.keybindslist.keybinds[aP] = nil;
                        aR = nil
                    end
                    function aR:Visibility()
                        aS.Visible = ae.keybindslist.visible;
                        aT.Visible = ae.keybindslist.visible;
                        aU.Visible = ae.keybindslist.visible;
                        aV.Visible = ae.keybindslist.visible;
                        aW.Visible = ae.keybindslist.visible
                    end
                    ae.keybindslist.keybinds[aP] = aR;
                    ae.keybindslist:Resort()
                end
            end
            function ae.keybindslist:Remove(aP)
                if aP and ae.keybindslist.keybinds[aP] then
                    ae.keybindslist.keybinds[aP]:Remove()
                    ae.keybindslist.keybinds[aP] = nil;
                    ae.keybindslist:Resort()
                end
            end
            function ae.keybindslist:Visibility()
                aJ.Visible = ae.keybindslist.visible;
                aK.Visible = ae.keybindslist.visible;
                aL.Visible = ae.keybindslist.visible;
                aM.Visible = ae.keybindslist.visible;
                aN.Visible = ae.keybindslist.visible;
                for F, G in pairs(ae.keybindslist.keybinds) do
                    G:Visibility()
                end
            end
            function ae.keybindslist:Update(aG, aH)
                if aG == "Visible" then
                    ae.keybindslist.visible = aH;
                    ae.keybindslist:Visibility()
                end
            end
            h:Connection(a.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), function()
                aJ.Position = h:Position(0, 10, 0.4, 0)
                aK.Position = h:Position(0, 1, 0, 1, aJ)
                aL.Position = h:Position(0, 1, 0, 1, aK)
                aM.Position = h:Position(0, 0, 0, 0, aL)
                aN.Position = h:Position(0.5, 0, 0, 5, aJ)
                ae.keybindslist:Resort()
            end)
        end
        function ae:Fade()
            ae.fading = true;
            ae.isVisible = not ae.isVisible;
            spawn(function()
                for F, G in pairs(g.drawings) do
                    h:Lerp(G[1], {
                        Transparency = ae.isVisible and G[3] or 0
                    }, 0.25)
                end
            end)
            ae.fading = false
        end
        function ae:Initialize()
            ae.pages[1]:Show()
            for F, G in pairs(ae.pages) do
                G:Update()
            end
            g.shared.initialized = true;
            ae:KeybindsList()
            ae:Fade()
        end
        g.began[#g.began + 1] = function(aY)
            if aY.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and ae.isVisible and
                h:MouseOverDrawing({af.Position.X, af.Position.Y, af.Position.X + af.Size.X, af.Position.Y + 20}) then
                local S = h:MouseLocation()
                ae.dragging = true;
                ae.drag = Vector2.new(S.X - af.Position.X, S.Y - af.Position.Y)
            end
        end;
        g.ended[#g.ended + 1] = function(aY)
            if aY.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and ae.dragging then
                ae.dragging = false;
                ae.drag = Vector2.new(0, 0)
            end
        end;
        g.changed[#g.changed + 1] = function(aY)
            if ae.dragging and ae.isVisible then
                local S = h:MouseLocation()
                if h:GetScreenSize().Y - af.Size.Y - 5 > 5 then
                    local aZ = Vector2.new(math.clamp(S.X - ae.drag.X, 5, h:GetScreenSize().X - af.Size.X - 5),
                        math.clamp(S.Y - ae.drag.Y, 5, h:GetScreenSize().Y - af.Size.Y - 5))
                    ae:Move(aZ)
                else
                    local aZ = Vector2.new(S.X - ae.drag.X, S.Y - ae.drag.Y)
                    ae:Move(aZ)
                end
            end
        end;
        g.began[#g.began + 1] = function(aY)
            if aY.KeyCode == ae.uibind then
                ae:Fade()
            end
        end;
        h:Connection(b.InputBegan, function(aY)
            for a_, b0 in pairs(g.began) do
                if not ae.dragging then
                    local b1, b2 = pcall(function()
                        b0(aY)
                    end)
                else
                    break
                end
            end
        end)
        h:Connection(b.InputEnded, function(aY)
            for a_, b0 in pairs(g.ended) do
                local b1, b2 = pcall(function()
                    b0(aY)
                end)
            end
        end)
        h:Connection(b.InputChanged, function()
            for a_, b0 in pairs(g.changed) do
                local b1, b2 = pcall(function()
                    b0()
                end)
            end
        end)
        h:Connection(a.CurrentCamera:GetPropertyChangedSignal("ViewportSize"), function()
            ae:Move(Vector2.new(h:GetScreenSize().X / 2 - ac.X / 2, h:GetScreenSize().Y / 2 - ac.Y / 2))
        end)
        return setmetatable(ae, g)
    end
    function g:Page(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Page"
        local ae = self;
        local b3 = {
            open = false,
            sections = {},
            sectionOffset = {
                left = 0,
                right = 0
            },
            window = ae
        }
        local b4 = 4;
        for F, G in pairs(ae.pages) do
            b4 = b4 + G.page_button.Size.X + 2
        end
        local V = h:GetTextBounds(ab, k.textsize, k.font)
        local b5 = h:Create("Frame", {Vector2.new(b4, 4), ae.back_frame}, {
            Size = h:Size(0, V.X + 20, 0, 21),
            Position = h:Position(0, b4, 0, 4, ae.back_frame),
            Color = k.outline
        })
        b3["page_button"] = b5;
        local b6 = h:Create("Frame", {Vector2.new(1, 1), b5}, {
            Size = h:Size(1, -2, 1, -1, b5),
            Position = h:Position(0, 1, 0, 1, b5),
            Color = k.inline
        })
        b3["page_button_inline"] = b6;
        local b7 = h:Create("Frame", {Vector2.new(1, 1), b6}, {
            Size = h:Size(1, -2, 1, -1, b6),
            Position = h:Position(0, 1, 0, 1, b6),
            Color = k.dark_contrast
        })
        b3["page_button_color"] = b7;
        local b8 = h:Create("TextLabel", {Vector2.new(h:Position(0.5, 0, 0, 2, b7).X - b7.Position.X, 2), b7}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            Center = true,
            OutlineColor = k.textborder,
            Position = h:Position(0.5, 0, 0, 2, b7)
        })
        ae.pages[#ae.pages + 1] = b3;
        function b3:Update()
            b3.sectionOffset["left"] = 0;
            b3.sectionOffset["right"] = 0;
            for F, G in pairs(b3.sections) do
                h:UpdateOffset(G.section_inline, {Vector2.new(G.side == "right" and ae.tab_frame.Size.X / 2 + 2 or 5,
                    5 + b3["sectionOffset"][G.side]), ae.tab_frame})
                b3.sectionOffset[G.side] = b3.sectionOffset[G.side] + G.section_inline.Size.Y + 5
            end
            ae:Move(ae.main_frame.Position)
        end
        function b3:Show()
            if ae.currentPage then
                ae.currentPage.page_button_color.Size = h:Size(1, -2, 1, -1, ae.currentPage.page_button_inline)
                ae.currentPage.page_button_color.Color = k.dark_contrast;
                ae.currentPage.open = false;
                for F, G in pairs(ae.currentPage.sections) do
                    for a9, q in pairs(G.visibleContent) do
                        q.Visible = false
                    end
                end
                ae:CloseContent()
            end
            ae.currentPage = b3;
            b7.Size = h:Size(1, -2, 1, 0, b6)
            b7.Color = k.light_contrast;
            b3.open = true;
            for F, G in pairs(b3.sections) do
                for a9, q in pairs(G.visibleContent) do
                    q.Visible = true
                end
            end
        end
        g.began[#g.began + 1] = function(aY)
            if aY.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and
                h:MouseOverDrawing({b5.Position.X, b5.Position.Y, b5.Position.X + b5.Size.X, b5.Position.Y + b5.Size.Y}) and
                ae.currentPage ~= b3 then
                b3:Show()
            end
        end;
        return setmetatable(b3, i)
    end
    function i:Section(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Section"
        local b9 = aa.side or aa.Side or "left"
        b9 = b9:lower()
        local ae = self.window;
        local b3 = self;
        local ba = {
            window = ae,
            page = b3,
            visibleContent = {},
            currentAxis = 20,
            side = b9
        }
        local bb = h:Create("Frame", {Vector2.new(b9 == "right" and ae.tab_frame.Size.X / 2 + 2 or 5,
            5 + b3["sectionOffset"][b9]), ae.tab_frame}, {
            Size = h:Size(0.5, -7, 0, 22, ae.tab_frame),
            Position = h:Position(b9 == "right" and 0.5 or 0, b9 == "right" and 2 or 5, 0, 5 + b3.sectionOffset[b9],
                ae.tab_frame),
            Color = k.inline,
            Visible = b3.open
        }, ba.visibleContent)
        ba["section_inline"] = bb;
        local bc = h:Create("Frame", {Vector2.new(1, 1), bb}, {
            Size = h:Size(1, -2, 1, -2, bb),
            Position = h:Position(0, 1, 0, 1, bb),
            Color = k.outline,
            Visible = b3.open
        }, ba.visibleContent)
        ba["section_outline"] = bc;
        local bd = h:Create("Frame", {Vector2.new(1, 1), bc}, {
            Size = h:Size(1, -2, 1, -2, bc),
            Position = h:Position(0, 1, 0, 1, bc),
            Color = k.dark_contrast,
            Visible = b3.open
        }, ba.visibleContent)
        ba["section_frame"] = bd;
        local be = h:Create("Frame", {Vector2.new(0, 0), bd}, {
            Size = h:Size(1, 0, 0, 2, bd),
            Position = h:Position(0, 0, 0, 0, bd),
            Color = k.accent,
            Visible = b3.open
        }, ba.visibleContent)
        ba["section_accent"] = be;
        local bf = h:Create("TextLabel", {Vector2.new(3, 3), bd}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 3, 0, 3, bd),
            Visible = b3.open
        }, ba.visibleContent)
        ba["section_title"] = bf;
        function ba:Update()
            bb.Size = h:Size(0.5, -7, 0, ba.currentAxis + 4, ae.tab_frame)
            bc.Size = h:Size(1, -2, 1, -2, bb)
            bd.Size = h:Size(1, -2, 1, -2, bc)
        end
        b3.sectionOffset[b9] = b3.sectionOffset[b9] + 100 + 5;
        b3.sections[#b3.sections + 1] = ba;
        return setmetatable(ba, j)
    end
    function i:MultiSection(aa)
        local aa = aa or {}
        local bg = aa.sections or aa.Sections or {}
        local b9 = aa.side or aa.Side or "left"
        local ac = aa.size or aa.Size or 150;
        b9 = b9:lower()
        local ae = self.window;
        local b3 = self;
        local bh = {
            window = ae,
            page = b3,
            sections = {},
            backup = {},
            visibleContent = {},
            currentSection = nil,
            xAxis = 0,
            side = b9
        }
        local bi = h:Create("Frame", {Vector2.new(b9 == "right" and ae.tab_frame.Size.X / 2 + 2 or 5,
            5 + b3["sectionOffset"][b9]), ae.tab_frame}, {
            Size = h:Size(0.5, -7, 0, ac, ae.tab_frame),
            Position = h:Position(b9 == "right" and 0.5 or 0, b9 == "right" and 2 or 5, 0, 5 + b3.sectionOffset[b9],
                ae.tab_frame),
            Color = k.inline,
            Visible = b3.open
        }, bh.visibleContent)
        bh["section_inline"] = bi;
        local bj = h:Create("Frame", {Vector2.new(1, 1), bi}, {
            Size = h:Size(1, -2, 1, -2, bi),
            Position = h:Position(0, 1, 0, 1, bi),
            Color = k.outline,
            Visible = b3.open
        }, bh.visibleContent)
        bh["section_outline"] = bj;
        local bk = h:Create("Frame", {Vector2.new(1, 1), bj}, {
            Size = h:Size(1, -2, 1, -2, bj),
            Position = h:Position(0, 1, 0, 1, bj),
            Color = k.dark_contrast,
            Visible = b3.open
        }, bh.visibleContent)
        bh["section_frame"] = bk;
        local bl = h:Create("Frame", {Vector2.new(0, 2), bk}, {
            Size = h:Size(1, 0, 0, 17, bk),
            Position = h:Position(0, 0, 0, 2, bk),
            Color = k.light_contrast,
            Visible = b3.open
        }, bh.visibleContent)
        local bm = h:Create("Frame", {Vector2.new(0, bl.Size.Y - 1), bl}, {
            Size = h:Size(1, 0, 0, 1, bl),
            Position = h:Position(0, 0, 1, -1, bl),
            Color = k.outline,
            Visible = b3.open
        }, bh.visibleContent)
        local bn = h:Create("Frame", {Vector2.new(0, 0), bk}, {
            Size = h:Size(1, 0, 0, 2, bk),
            Position = h:Position(0, 0, 0, 0, bk),
            Color = k.accent,
            Visible = b3.open
        }, bh.visibleContent)
        bh["section_accent"] = bn;
        for F, G in pairs(bg) do
            local bo = {
                window = ae,
                page = b3,
                currentAxis = 24,
                sections = {},
                visibleContent = {},
                section_inline = bi,
                section_outline = bj,
                section_frame = bk,
                section_accent = bn
            }
            local bp = h:GetTextBounds(G, k.textsize, k.font)
            local bq = h:Create("Frame", {Vector2.new(bh.xAxis, 0), bl}, {
                Size = h:Size(0, bp.X + 14, 1, -1, bl),
                Position = h:Position(0, bh.xAxis, 0, 0, bl),
                Color = F == 1 and k.dark_contrast or k.light_contrast,
                Visible = b3.open
            }, bh.visibleContent)
            bo["msection_frame"] = bq;
            local br = h:Create("Frame", {Vector2.new(bq.Size.X, 0), bq}, {
                Size = h:Size(0, 1, 1, 0, bq),
                Position = h:Position(1, 0, 0, 0, bq),
                Color = k.outline,
                Visible = b3.open
            }, bh.visibleContent)
            local bs = h:Create("TextLabel", {Vector2.new(bq.Size.X * 0.5, 1), bq}, {
                Text = G,
                Size = k.textsize,
                Font = k.font,
                Color = k.textcolor,
                OutlineColor = k.textborder,
                Center = true,
                Position = h:Position(0.5, 0, 0, 1, bq),
                Visible = b3.open
            }, bh.visibleContent)
            local bt = h:Create("Frame", {Vector2.new(0, bq.Size.Y), bq}, {
                Size = h:Size(1, 0, 0, 1, bq),
                Position = h:Position(0, 0, 1, 0, bq),
                Color = F == 1 and k.dark_contrast or k.outline,
                Visible = b3.open
            }, bh.visibleContent)
            bo["msection_bottomline"] = bt;
            function bo:Update()
                if bh.currentSection == bo then
                    bh.visibleContent = h:Combine(bh.backup, bh.currentSection.visibleContent)
                else
                    for a9, q in pairs(bo.visibleContent) do
                        q.Visible = false
                    end
                end
            end
            g.began[#g.began + 1] = function(aY)
                if aY.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and b3.open and
                    h:MouseOverDrawing(
                        {bq.Position.X, bq.Position.Y, bq.Position.X + bq.Size.X, bq.Position.Y + bq.Size.Y}) and
                    bh.currentSection ~= bo and not ae:IsOverContent() then
                    bh.currentSection.msection_frame.Color = k.light_contrast;
                    bh.currentSection.msection_bottomline.Color = k.outline;
                    for F, G in pairs(bh.currentSection.visibleContent) do
                        G.Visible = false
                    end
                    bh.currentSection = bo;
                    bq.Color = k.dark_contrast;
                    bt.Color = k.dark_contrast;
                    for F, G in pairs(bh.currentSection.visibleContent) do
                        G.Visible = true
                    end
                    bh.visibleContent = h:Combine(bh.backup, bh.currentSection.visibleContent)
                end
            end;
            if F == 1 then
                bh.currentSection = bo
            end
            bh.sections[#bh.sections + 1] = setmetatable(bo, j)
            bh.xAxis = bh.xAxis + bp.X + 15
        end
        for a9, q in pairs(bh.visibleContent) do
            bh.backup[a9] = q
        end
        b3.sectionOffset[b9] = b3.sectionOffset[b9] + 100 + 5;
        b3.sections[#b3.sections + 1] = bh;
        return table.unpack(bh.sections)
    end
    function j:Label(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Label"
        local bu = aa.middle or aa.Middle or false;
        local bv = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
        local ae = self.window;
        local b3 = self.page;
        local ba = self;
        local bw = {
            axis = ba.currentAxis
        }
        local bx = h:Create("TextLabel",
            {Vector2.new(bu and ba.section_frame.Size.X / 2 or 4, bw.axis), ba.section_frame}, {
                Text = ab,
                Size = k.textsize,
                Font = k.font,
                Color = k.textcolor,
                OutlineColor = k.textborder,
                Center = bu,
                Position = h:Position(bu and 0.5 or 0, bu and 0 or 4, 0, 0, ba.section_frame),
                Visible = b3.open
            }, ba.visibleContent)
        if bv and tostring(bv) ~= "" and tostring(bv) ~= " " and not g.pointers[tostring(bv)] then
            g.pointers[tostring(bv)] = bw
        end
        ba.currentAxis = ba.currentAxis + bx.TextBounds.Y + 4;
        ba:Update()
        return bw
    end
    function j:Toggle(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Toggle"
        local by = aa.def or aa.Def or aa.default or aa.Default or false;
        local bv = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
        local bz = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
        end;
        local ae = self.window;
        local b3 = self.page;
        local ba = self;
        local bA = {
            axis = ba.currentAxis,
            current = by,
            addedAxis = 0,
            colorpickers = 0,
            keybind = nil
        }
        local bB = h:Create("Frame", {Vector2.new(4, bA.axis), ba.section_frame}, {
            Size = h:Size(0, 15, 0, 15),
            Position = h:Position(0, 4, 0, bA.axis, ba.section_frame),
            Color = k.outline,
            Visible = b3.open
        }, ba.visibleContent)
        local bC = h:Create("Frame", {Vector2.new(1, 1), bB}, {
            Size = h:Size(1, -2, 1, -2, bB),
            Position = h:Position(0, 1, 0, 1, bB),
            Color = k.inline,
            Visible = b3.open
        }, ba.visibleContent)
        local bD = h:Create("Frame", {Vector2.new(1, 1), bC}, {
            Size = h:Size(1, -2, 1, -2, bC),
            Position = h:Position(0, 1, 0, 1, bC),
            Color = bA.current == true and k.accent or k.light_contrast,
            Visible = b3.open
        }, ba.visibleContent)
        local bE = h:Create("Image", {Vector2.new(0, 0), bD}, {
            Size = h:Size(1, 0, 1, 0, bD),
            Position = h:Position(0, 0, 0, 0, bD),
            Transparency = 0.5,
            Visible = b3.open
        }, ba.visibleContent)
        local bF = h:Create("TextLabel", {Vector2.new(23,
            bA.axis + 15 / 2 - h:GetTextBounds(ab, k.textsize, k.font).Y / 2), ba.section_frame}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 23, 0, bA.axis + 15 / 2 - h:GetTextBounds(ab, k.textsize, k.font).Y / 2,
                ba.section_frame),
            Visible = b3.open
        }, ba.visibleContent)
        h:LoadImage(bE, "gradient", "https://i.imgur.com/5hmlrjX.png")
        function bA:Get()
            return bA.current
        end
        function bA:Set(bG)
            if bG or not bG then
                bA.current = bG;
                bD.Color = bA.current == true and k.accent or k.light_contrast;
                bz(bA.current)
            end
        end
        g.began[#g.began + 1] = function(aY)
            if aY.UserInputType == Enum.UserInputType.MouseButton1 and bB.Visible and ae.isVisible and b3.open and
                h:MouseOverDrawing({ba.section_frame.Position.X, ba.section_frame.Position.Y + bA.axis,
                                    ba.section_frame.Position.X + ba.section_frame.Size.X - bA.addedAxis,
                                    ba.section_frame.Position.Y + bA.axis + 15}) and not ae:IsOverContent() then
                bA.current = not bA.current;
                bD.Color = bA.current == true and k.accent or k.light_contrast;
                bz(bA.current)
                if bA.keybind and bA.keybind.active then
                    bA.keybind.active = false;
                    ae.keybindslist:Remove(bA.keybind.keybindname)
                end
            end
        end;
        if bv and tostring(bv) ~= "" and tostring(bv) ~= " " and not g.pointers[tostring(bv)] then
            g.pointers[tostring(bv)] = bA
        end
        ba.currentAxis = ba.currentAxis + 15 + 4;
        ba:Update()
        function bA:Colorpicker(aa)
            local aa = aa or {}
            local bH = aa.info or aa.Info or ab;
            local by = aa.def or aa.Def or aa.default or aa.Default or Color3.fromRGB(255, 0, 0)
            local bI = aa.transparency or aa.Transparency or aa.transp or aa.Transp or aa.alpha or aa.Alpha or nil;
            local bv = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
            local bz = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
            end;
            local bJ, bK, bL = by:ToHSV()
            local aw = {
                bA,
                axis = bA.axis,
                index = bA.colorpickers,
                current = {bJ, bK, bL, bI or 0},
                holding = {
                    picker = false,
                    huepicker = false,
                    transparency = false
                },
                holder = {
                    inline = nil,
                    picker = nil,
                    picker_cursor = nil,
                    huepicker = nil,
                    huepicker_cursor = {},
                    transparency = nil,
                    transparencybg = nil,
                    transparency_cursor = {},
                    drawings = {}
                }
            }
            local bM = h:Create("Frame", {Vector2.new(
                ba.section_frame.Size.X - (bA.colorpickers == 0 and 30 + 4 or 64 + 4), aw.axis), ba.section_frame}, {
                Size = h:Size(0, 30, 0, 15),
                Position = h:Position(1, -(bA.colorpickers == 0 and 30 + 4 or 64 + 4), 0, aw.axis, ba.section_frame),
                Color = k.outline,
                Visible = b3.open
            }, ba.visibleContent)
            local bN = h:Create("Frame", {Vector2.new(1, 1), bM}, {
                Size = h:Size(1, -2, 1, -2, bM),
                Position = h:Position(0, 1, 0, 1, bM),
                Color = k.inline,
                Visible = b3.open
            }, ba.visibleContent)
            local bO;
            if bI then
                bO = h:Create("Image", {Vector2.new(1, 1), bN}, {
                    Size = h:Size(1, -2, 1, -2, bN),
                    Position = h:Position(0, 1, 0, 1, bN),
                    Visible = b3.open
                }, ba.visibleContent)
            end
            local bP = h:Create("Frame", {Vector2.new(1, 1), bN}, {
                Size = h:Size(1, -2, 1, -2, bN),
                Position = h:Position(0, 1, 0, 1, bN),
                Color = by,
                Transparency = bI and 1 - bI or 1,
                Visible = b3.open
            }, ba.visibleContent)
            local bQ = h:Create("Image", {Vector2.new(0, 0), bP}, {
                Size = h:Size(1, 0, 1, 0, bP),
                Position = h:Position(0, 0, 0, 0, bP),
                Transparency = 0.5,
                Visible = b3.open
            }, ba.visibleContent)
            if bI then
                h:LoadImage(bO, "cptransp", "https://i.imgur.com/IIPee2A.png")
            end
            h:LoadImage(bQ, "gradient", "https://i.imgur.com/5hmlrjX.png")
            function aw:Set(bR, bS)
                if typeof(bR) == "table" then
                    if bR.Color and bR.Transparency then
                        local bT, b2, G = table.unpack(bR.Color)
                        aw.current = {bT, b2, G, bR.Transparency}
                        bP.Color = Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3])
                        bP.Transparency = 1 - aw.current[4]
                        bz(Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3]), aw.current[4])
                    else
                        aw.current = bR;
                        bP.Color = Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3])
                        bP.Transparency = 1 - aw.current[4]
                        bz(Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3]), aw.current[4])
                    end
                elseif typeof(bR) == "color3" then
                    local bT, b2, G = bR:ToHSV()
                    aw.current = {bT, b2, G, bS or 0}
                    bP.Color = Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3])
                    bP.Transparency = 1 - aw.current[4]
                    bz(Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3]), aw.current[4])
                end
            end
            function aw:Refresh()
                local S = h:MouseLocation()
                if aw.open and aw.holder.picker and aw.holding.picker then
                    aw.current[2] = math.clamp(S.X - aw.holder.picker.Position.X, 0, aw.holder.picker.Size.X) /
                                        aw.holder.picker.Size.X;
                    aw.current[3] = 1 - math.clamp(S.Y - aw.holder.picker.Position.Y, 0, aw.holder.picker.Size.Y) /
                                        aw.holder.picker.Size.Y;
                    aw.holder.picker_cursor.Position = h:Position(aw.current[2], -3, 1 - aw.current[3], -3,
                        aw.holder.picker)
                    h:UpdateOffset(aw.holder.picker_cursor,
                        {Vector2.new(aw.holder.picker.Size.X * aw.current[2] - 3,
                            aw.holder.picker.Size.Y * (1 - aw.current[3]) - 3), aw.holder.picker})
                    if aw.holder.transparencybg then
                        aw.holder.transparencybg.Color = Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3])
                    end
                elseif aw.open and aw.holder.huepicker and aw.holding.huepicker then
                    aw.current[1] = math.clamp(S.Y - aw.holder.huepicker.Position.Y, 0, aw.holder.huepicker.Size.Y) /
                                        aw.holder.huepicker.Size.Y;
                    aw.holder.huepicker_cursor[1].Position = h:Position(0, -3, aw.current[1], -3, aw.holder.huepicker)
                    aw.holder.huepicker_cursor[2].Position = h:Position(0, 1, 0, 1, aw.holder.huepicker_cursor[1])
                    aw.holder.huepicker_cursor[3].Position = h:Position(0, 1, 0, 1, aw.holder.huepicker_cursor[2])
                    aw.holder.huepicker_cursor[3].Color = Color3.fromHSV(aw.current[1], 1, 1)
                    h:UpdateOffset(aw.holder.huepicker_cursor[1], {Vector2.new(-3, aw.holder.huepicker.Size.Y *
                        aw.current[1] - 3), aw.holder.huepicker})
                    aw.holder.background.Color = Color3.fromHSV(aw.current[1], 1, 1)
                    if aw.holder.transparency_cursor and aw.holder.transparency_cursor[3] then
                        aw.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - aw.current[4])
                    end
                    if aw.holder.transparencybg then
                        aw.holder.transparencybg.Color = Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3])
                    end
                elseif aw.open and aw.holder.transparency and aw.holding.transparency then
                    aw.current[4] = 1 -
                                        math.clamp(S.X - aw.holder.transparency.Position.X, 0,
                            aw.holder.transparency.Size.X) / aw.holder.transparency.Size.X;
                    aw.holder.transparency_cursor[1].Position =
                        h:Position(1 - aw.current[4], -3, 0, -3, aw.holder.transparency)
                    aw.holder.transparency_cursor[2].Position = h:Position(0, 1, 0, 1, aw.holder.transparency_cursor[1])
                    aw.holder.transparency_cursor[3].Position = h:Position(0, 1, 0, 1, aw.holder.transparency_cursor[2])
                    aw.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - aw.current[4])
                    bP.Transparency = 1 - aw.current[4]
                    h:UpdateTransparency(bP, 1 - aw.current[4])
                    h:UpdateOffset(aw.holder.transparency_cursor[1], {Vector2.new(
                        aw.holder.transparency.Size.X * (1 - aw.current[4]) - 3, -3), aw.holder.transparency})
                    aw.holder.background.Color = Color3.fromHSV(aw.current[1], 1, 1)
                end
                aw:Set(aw.current)
            end
            function aw:Get()
                return {
                    Color = Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3]),
                    Transparency = aw.current[4]
                }
            end
            g.began[#g.began + 1] = function(aY)
                if aY.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and bM.Visible then
                    if aw.open and aw.holder.inline and
                        h:MouseOverDrawing({aw.holder.inline.Position.X, aw.holder.inline.Position.Y,
                                            aw.holder.inline.Position.X + aw.holder.inline.Size.X,
                                            aw.holder.inline.Position.Y + aw.holder.inline.Size.Y}) then
                        if aw.holder.picker and
                            h:MouseOverDrawing({aw.holder.picker.Position.X - 2, aw.holder.picker.Position.Y - 2,
                                                aw.holder.picker.Position.X - 2 + aw.holder.picker.Size.X + 4,
                                                aw.holder.picker.Position.Y - 2 + aw.holder.picker.Size.Y + 4}) then
                            aw.holding.picker = true;
                            aw:Refresh()
                        elseif aw.holder.huepicker and
                            h:MouseOverDrawing({aw.holder.huepicker.Position.X - 2, aw.holder.huepicker.Position.Y - 2,
                                                aw.holder.huepicker.Position.X - 2 + aw.holder.huepicker.Size.X + 4,
                                                aw.holder.huepicker.Position.Y - 2 + aw.holder.huepicker.Size.Y + 4}) then
                            aw.holding.huepicker = true;
                            aw:Refresh()
                        elseif aw.holder.transparency and
                            h:MouseOverDrawing(
                                {aw.holder.transparency.Position.X - 2, aw.holder.transparency.Position.Y - 2,
                                 aw.holder.transparency.Position.X - 2 + aw.holder.transparency.Size.X + 4,
                                 aw.holder.transparency.Position.Y - 2 + aw.holder.transparency.Size.Y + 4}) then
                            aw.holding.transparency = true;
                            aw:Refresh()
                        end
                    elseif h:MouseOverDrawing({ba.section_frame.Position.X + ba.section_frame.Size.X -
                        (aw.index == 0 and 30 + 4 + 2 or 64 + 4 + 2), ba.section_frame.Position.Y + aw.axis,
                                               ba.section_frame.Position.X + ba.section_frame.Size.X -
                        (aw.index == 1 and 36 or 0), ba.section_frame.Position.Y + aw.axis + 15}) and
                        not ae:IsOverContent() then
                        if not aw.open then
                            ae:CloseContent()
                            aw.open = not aw.open;
                            local bU = h:Create("Frame", {Vector2.new(4, aw.axis + 19), ba.section_frame}, {
                                Size = h:Size(1, -8, 0, bI and 219 or 200, ba.section_frame),
                                Position = h:Position(0, 4, 0, aw.axis + 19, ba.section_frame),
                                Color = k.outline
                            }, aw.holder.drawings)
                            aw.holder.inline = bU;
                            local bV = h:Create("Frame", {Vector2.new(1, 1), bU}, {
                                Size = h:Size(1, -2, 1, -2, bU),
                                Position = h:Position(0, 1, 0, 1, bU),
                                Color = k.inline
                            }, aw.holder.drawings)
                            local bW = h:Create("Frame", {Vector2.new(1, 1), bV}, {
                                Size = h:Size(1, -2, 1, -2, bV),
                                Position = h:Position(0, 1, 0, 1, bV),
                                Color = k.dark_contrast
                            }, aw.holder.drawings)
                            local bX = h:Create("Frame", {Vector2.new(0, 0), bW}, {
                                Size = h:Size(1, 0, 0, 2, bW),
                                Position = h:Position(0, 0, 0, 0, bW),
                                Color = k.accent
                            }, aw.holder.drawings)
                            local bY = h:Create("TextLabel", {Vector2.new(4, 2), bW}, {
                                Text = bH,
                                Size = k.textsize,
                                Font = k.font,
                                Color = k.textcolor,
                                OutlineColor = k.textborder,
                                Position = h:Position(0, 4, 0, 2, bW)
                            }, aw.holder.drawings)
                            local bZ = h:Create("Frame", {Vector2.new(4, 17), bW}, {
                                Size = h:Size(1, -27, 1, bI and -40 or -21, bW),
                                Position = h:Position(0, 4, 0, 17, bW),
                                Color = k.outline
                            }, aw.holder.drawings)
                            local b_ = h:Create("Frame", {Vector2.new(1, 1), bZ}, {
                                Size = h:Size(1, -2, 1, -2, bZ),
                                Position = h:Position(0, 1, 0, 1, bZ),
                                Color = k.inline
                            }, aw.holder.drawings)
                            local c0 = h:Create("Frame", {Vector2.new(1, 1), b_}, {
                                Size = h:Size(1, -2, 1, -2, b_),
                                Position = h:Position(0, 1, 0, 1, b_),
                                Color = Color3.fromHSV(aw.current[1], 1, 1)
                            }, aw.holder.drawings)
                            aw.holder.background = c0;
                            local c1 = h:Create("Image", {Vector2.new(0, 0), c0}, {
                                Size = h:Size(1, 0, 1, 0, c0),
                                Position = h:Position(0, 0, 0, 0, c0)
                            }, aw.holder.drawings)
                            aw.holder.picker = c1;
                            local c2 = h:Create("Image", {Vector2.new(c1.Size.X * aw.current[2] - 3,
                                c1.Size.Y * (1 - aw.current[3]) - 3), c1}, {
                                Size = h:Size(0, 6, 0, 6, c1),
                                Position = h:Position(aw.current[2], -3, 1 - aw.current[3], -3, c1)
                            }, aw.holder.drawings)
                            aw.holder.picker_cursor = c2;
                            local c3 = h:Create("Frame", {Vector2.new(bW.Size.X - 19, 17), bW}, {
                                Size = h:Size(0, 15, 1, bI and -40 or -21, bW),
                                Position = h:Position(1, -19, 0, 17, bW),
                                Color = k.outline
                            }, aw.holder.drawings)
                            local c4 = h:Create("Frame", {Vector2.new(1, 1), c3}, {
                                Size = h:Size(1, -2, 1, -2, c3),
                                Position = h:Position(0, 1, 0, 1, c3),
                                Color = k.inline
                            }, aw.holder.drawings)
                            local c5 = h:Create("Image", {Vector2.new(1, 1), c4}, {
                                Size = h:Size(1, -2, 1, -2, c4),
                                Position = h:Position(0, 1, 0, 1, c4)
                            }, aw.holder.drawings)
                            aw.holder.huepicker = c5;
                            local c6 = h:Create("Frame", {Vector2.new(-3, c5.Size.Y * aw.current[1] - 3), c5}, {
                                Size = h:Size(1, 6, 0, 6, c5),
                                Position = h:Position(0, -3, aw.current[1], -3, c5),
                                Color = k.outline
                            }, aw.holder.drawings)
                            aw.holder.huepicker_cursor[1] = c6;
                            local c7 = h:Create("Frame", {Vector2.new(1, 1), c6}, {
                                Size = h:Size(1, -2, 1, -2, c6),
                                Position = h:Position(0, 1, 0, 1, c6),
                                Color = k.textcolor
                            }, aw.holder.drawings)
                            aw.holder.huepicker_cursor[2] = c7;
                            local c8 = h:Create("Frame", {Vector2.new(1, 1), c7}, {
                                Size = h:Size(1, -2, 1, -2, c7),
                                Position = h:Position(0, 1, 0, 1, c7),
                                Color = Color3.fromHSV(aw.current[1], 1, 1)
                            }, aw.holder.drawings)
                            aw.holder.huepicker_cursor[3] = c8;
                            if bI then
                                local c9 = h:Create("Frame", {Vector2.new(4, bW.Size.X - 19), bW}, {
                                    Size = h:Size(1, -27, 0, 15, bW),
                                    Position = h:Position(0, 4, 1, -19, bW),
                                    Color = k.outline
                                }, aw.holder.drawings)
                                local ca = h:Create("Frame", {Vector2.new(1, 1), c9}, {
                                    Size = h:Size(1, -2, 1, -2, c9),
                                    Position = h:Position(0, 1, 0, 1, c9),
                                    Color = k.inline
                                }, aw.holder.drawings)
                                local cb = h:Create("Frame", {Vector2.new(1, 1), ca}, {
                                    Size = h:Size(1, -2, 1, -2, ca),
                                    Position = h:Position(0, 1, 0, 1, ca),
                                    Color = Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3])
                                }, aw.holder.drawings)
                                aw.holder.transparencybg = cb;
                                local cc = h:Create("Image", {Vector2.new(1, 1), ca}, {
                                    Size = h:Size(1, -2, 1, -2, ca),
                                    Position = h:Position(0, 1, 0, 1, ca)
                                }, aw.holder.drawings)
                                aw.holder.transparency = cc;
                                local cd = h:Create("Frame", {Vector2.new(cc.Size.X * (1 - aw.current[4]) - 3, -3), cc},
                                    {
                                        Size = h:Size(0, 6, 1, 6, cc),
                                        Position = h:Position(1 - aw.current[4], -3, 0, -3, cc),
                                        Color = k.outline
                                    }, aw.holder.drawings)
                                aw.holder.transparency_cursor[1] = cd;
                                local ce = h:Create("Frame", {Vector2.new(1, 1), cd}, {
                                    Size = h:Size(1, -2, 1, -2, cd),
                                    Position = h:Position(0, 1, 0, 1, cd),
                                    Color = k.textcolor
                                }, aw.holder.drawings)
                                aw.holder.transparency_cursor[2] = ce;
                                local cf = h:Create("Frame", {Vector2.new(1, 1), ce}, {
                                    Size = h:Size(1, -2, 1, -2, ce),
                                    Position = h:Position(0, 1, 0, 1, ce),
                                    Color = Color3.fromHSV(0, 0, 1 - aw.current[4])
                                }, aw.holder.drawings)
                                aw.holder.transparency_cursor[3] = cf;
                                h:LoadImage(cc, "transp", "https://i.imgur.com/ncssKbH.png")
                            end
                            h:LoadImage(c1, "valsat", "https://i.imgur.com/wpDRqVH.png")
                            h:LoadImage(c5, "hue", "https://i.imgur.com/iEOsHFv.png")
                            ae.currentContent.frame = bV;
                            ae.currentContent.colorpicker = aw
                        else
                            aw.open = not aw.open;
                            for F, G in pairs(aw.holder.drawings) do
                                h:Remove(G)
                            end
                            aw.holder.drawings = {}
                            aw.holder.inline = nil;
                            ae.currentContent.frame = nil;
                            ae.currentContent.colorpicker = nil
                        end
                    else
                        if aw.open then
                            aw.open = not aw.open;
                            for F, G in pairs(aw.holder.drawings) do
                                h:Remove(G)
                            end
                            aw.holder.drawings = {}
                            aw.holder.inline = nil;
                            ae.currentContent.frame = nil;
                            ae.currentContent.colorpicker = nil
                        end
                    end
                elseif aY.UserInputType == Enum.UserInputType.MouseButton1 and aw.open then
                    aw.open = not aw.open;
                    for F, G in pairs(aw.holder.drawings) do
                        h:Remove(G)
                    end
                    aw.holder.drawings = {}
                    aw.holder.inline = nil;
                    ae.currentContent.frame = nil;
                    ae.currentContent.colorpicker = nil
                end
            end;
            g.ended[#g.ended + 1] = function(aY)
                if aY.UserInputType == Enum.UserInputType.MouseButton1 then
                    if aw.holding.picker then
                        aw.holding.picker = not aw.holding.picker
                    end
                    if aw.holding.huepicker then
                        aw.holding.huepicker = not aw.holding.huepicker
                    end
                    if aw.holding.transparency then
                        aw.holding.transparency = not aw.holding.transparency
                    end
                end
            end;
            g.changed[#g.changed + 1] = function()
                if aw.open and aw.holding.picker or aw.holding.huepicker or aw.holding.transparency then
                    if ae.isVisible then
                        aw:Refresh()
                    else
                        if aw.holding.picker then
                            aw.holding.picker = not aw.holding.picker
                        end
                        if aw.holding.huepicker then
                            aw.holding.huepicker = not aw.holding.huepicker
                        end
                        if aw.holding.transparency then
                            aw.holding.transparency = not aw.holding.transparency
                        end
                    end
                end
            end;
            if bv and tostring(bv) ~= "" and tostring(bv) ~= " " and not g.pointers[tostring(bv)] then
                g.pointers[tostring(bv)] = aw
            end
            bA.addedAxis = bA.addedAxis + 30 + 4 + 2;
            bA.colorpickers = bA.colorpickers + 1;
            ba:Update()
            return aw, bA
        end
        function bA:Keybind(aa)
            local aa = aa or {}
            local by = aa.def or aa.Def or aa.default or aa.Default or nil;
            local bv = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
            local cg = aa.mode or aa.Mode or "Always"
            local aP = aa.keybindname or aa.keybindName or aa.KeybindName or aa.Keybindname or nil;
            local bz = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
            end;
            bA.addedaxis = bA.addedAxis + 40 + 4 + 2;
            local keybind = {
                keybindname = aP or ab,
                axis = bA.axis,
                current = {},
                selecting = false,
                mode = cg,
                open = false,
                modemenu = {
                    buttons = {},
                    drawings = {}
                },
                active = false
            }
            bA.keybind = keybind;
            local ch = {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L",
                        "Z", "X", "C", "V", "B", "N", "M", "One", "Two", "Three", "Four", "Five", "Six", "Seveen",
                        "Eight", "Nine", "0", "Insert", "Tab", "Home", "End", "LeftAlt", "LeftControl", "LeftShift",
                        "RightAlt", "RightControl", "RightShift", "CapsLock"}
            local ci = {"MouseButton1", "MouseButton2", "MouseButton3"}
            local cj = {
                ["MouseButton1"] = "MB1",
                ["MouseButton2"] = "MB2",
                ["MouseButton3"] = "MB3",
                ["Insert"] = "Ins",
                ["LeftAlt"] = "LAlt",
                ["LeftControl"] = "LC",
                ["LeftShift"] = "LS",
                ["RightAlt"] = "RAlt",
                ["RightControl"] = "RC",
                ["RightShift"] = "RS",
                ["CapsLock"] = "Caps"
            }
            local aS = h:Create("Frame",
                {Vector2.new(ba.section_frame.Size.X - (40 + 4), keybind.axis), ba.section_frame}, {
                    Size = h:Size(0, 40, 0, 17),
                    Position = h:Position(1, -(40 + 4), 0, keybind.axis, ba.section_frame),
                    Color = k.outline,
                    Visible = b3.open
                }, ba.visibleContent)
            local aT = h:Create("Frame", {Vector2.new(1, 1), aS}, {
                Size = h:Size(1, -2, 1, -2, aS),
                Position = h:Position(0, 1, 0, 1, aS),
                Color = k.inline,
                Visible = b3.open
            }, ba.visibleContent)
            local aU = h:Create("Frame", {Vector2.new(1, 1), aT}, {
                Size = h:Size(1, -2, 1, -2, aT),
                Position = h:Position(0, 1, 0, 1, aT),
                Color = k.light_contrast,
                Visible = b3.open
            }, ba.visibleContent)
            local ck = h:Create("Image", {Vector2.new(0, 0), aU}, {
                Size = h:Size(1, 0, 1, 0, aU),
                Position = h:Position(0, 0, 0, 0, aU),
                Transparency = 0.5,
                Visible = b3.open
            }, ba.visibleContent)
            local aW = h:Create("TextLabel", {Vector2.new(aS.Size.X / 2, 1), aS}, {
                Text = "...",
                Size = k.textsize,
                Font = k.font,
                Color = k.textcolor,
                OutlineColor = k.textborder,
                Center = true,
                Position = h:Position(0.5, 0, 1, 0, aS),
                Visible = b3.open
            }, ba.visibleContent)
            h:LoadImage(ck, "gradient", "https://i.imgur.com/5hmlrjX.png")
            function keybind:Shorten(string)
                for F, G in pairs(cj) do
                    string = string.gsub(string, F, G)
                end
                return string
            end
            function keybind:Change(cl)
                cl = cl or "..."
                local cm = {}
                if cl.EnumType then
                    if cl.EnumType == Enum.KeyCode or cl.EnumType == Enum.UserInputType then
                        if table.find(ch, cl.Name) or table.find(ci, cl.Name) then
                            cm = {cl.EnumType == Enum.KeyCode and "KeyCode" or "UserInputType", cl.Name}
                            keybind.current = cm;
                            aW.Text = #keybind.current > 0 and keybind:Shorten(keybind.current[2]) or "..."
                            return true
                        end
                    end
                end
                return false
            end
            function keybind:Get()
                return keybind.current
            end
            function keybind:Set(cn)
                keybind.current = cn;
                aW.Text = #keybind.current > 0 and keybind:Shorten(keybind.current[2]) or "..."
            end
            function keybind:Active()
                return keybind.active
            end
            function keybind:Reset()
                for F, G in pairs(keybind.modemenu.buttons) do
                    G.Color = G.Text == keybind.mode and k.accent or k.textcolor
                end
                keybind.active = keybind.mode == "Always" and true or false;
                if keybind.current[1] and keybind.current[2] then
                    bz(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                end
            end
            keybind:Change(by)
            g.began[#g.began + 1] = function(aY)
                if keybind.current[1] and keybind.current[2] then
                    if aY.KeyCode == Enum[keybind.current[1]][keybind.current[2]] or aY.UserInputType ==
                        Enum[keybind.current[1]][keybind.current[2]] then
                        if keybind.mode == "Hold" then
                            local co = keybind.active;
                            keybind.active = bA:Get()
                            if keybind.active then
                                ae.keybindslist:Add(aP or ab, aW.Text)
                            else
                                ae.keybindslist:Remove(aP or ab)
                            end
                            if keybind.active ~= co then
                                bz(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                            end
                        elseif keybind.mode == "Toggle" then
                            local co = keybind.active;
                            keybind.active = not keybind.active == true and bA:Get() or false;
                            if keybind.active then
                                ae.keybindslist:Add(aP or ab, aW.Text)
                            else
                                ae.keybindslist:Remove(aP or ab)
                            end
                            if keybind.active ~= co then
                                bz(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                            end
                        end
                    end
                end
                if keybind.selecting and ae.isVisible then
                    local cp = keybind:Change(aY.KeyCode.Name ~= "Unknown" and aY.KeyCode or aY.UserInputType)
                    if cp then
                        keybind.selecting = false;
                        keybind.active = keybind.mode == "Always" and true or false;
                        aU.Color = k.light_contrast;
                        ae.keybindslist:Remove(aP or ab)
                        bz(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                    end
                end
                if not ae.isVisible and keybind.selecting then
                    keybind.selecting = false;
                    aU.Color = k.light_contrast
                end
                if aY.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and aS.Visible then
                    if h:MouseOverDrawing({ba.section_frame.Position.X + ba.section_frame.Size.X - (40 + 4 + 2),
                                           ba.section_frame.Position.Y + keybind.axis,
                                           ba.section_frame.Position.X + ba.section_frame.Size.X,
                                           ba.section_frame.Position.Y + keybind.axis + 17}) and not ae:IsOverContent() and
                        not keybind.selecting then
                        keybind.selecting = true;
                        aU.Color = k.dark_contrast
                    end
                    if keybind.open and keybind.modemenu.frame then
                        if h:MouseOverDrawing({keybind.modemenu.frame.Position.X, keybind.modemenu.frame.Position.Y,
                                               keybind.modemenu.frame.Position.X + keybind.modemenu.frame.Size.X,
                                               keybind.modemenu.frame.Position.Y + keybind.modemenu.frame.Size.Y}) then
                            local cq = false;
                            for F, G in pairs(keybind.modemenu.buttons) do
                                if h:MouseOverDrawing({keybind.modemenu.frame.Position.X,
                                                       keybind.modemenu.frame.Position.Y + 15 * (F - 1),
                                                       keybind.modemenu.frame.Position.X + keybind.modemenu.frame.Size.X,
                                                       keybind.modemenu.frame.Position.Y + 15 * (F - 1) + 15}) then
                                    keybind.mode = G.Text;
                                    cq = true
                                end
                            end
                            if cq then
                                keybind:Reset()
                            end
                        else
                            keybind.open = not keybind.open;
                            for F, G in pairs(keybind.modemenu.drawings) do
                                h:Remove(G)
                            end
                            keybind.modemenu.drawings = {}
                            keybind.modemenu.buttons = {}
                            keybind.modemenu.frame = nil;
                            ae.currentContent.frame = nil;
                            ae.currentContent.keybind = nil
                        end
                    end
                end
                if aY.UserInputType == Enum.UserInputType.MouseButton2 and ae.isVisible and aS.Visible then
                    if h:MouseOverDrawing({ba.section_frame.Position.X + ba.section_frame.Size.X - (40 + 4 + 2),
                                           ba.section_frame.Position.Y + keybind.axis,
                                           ba.section_frame.Position.X + ba.section_frame.Size.X,
                                           ba.section_frame.Position.Y + keybind.axis + 17}) and not ae:IsOverContent() and
                        not keybind.selecting then
                        ae:CloseContent()
                        keybind.open = not keybind.open;
                        local ax = h:Create("Frame", {Vector2.new(aS.Size.X + 2, 0), aS}, {
                            Size = h:Size(0, 64, 0, 49),
                            Position = h:Position(1, 2, 0, 0, aS),
                            Color = k.outline,
                            Visible = b3.open
                        }, keybind.modemenu.drawings)
                        keybind.modemenu.frame = ax;
                        local cr = h:Create("Frame", {Vector2.new(1, 1), ax}, {
                            Size = h:Size(1, -2, 1, -2, ax),
                            Position = h:Position(0, 1, 0, 1, ax),
                            Color = k.inline,
                            Visible = b3.open
                        }, keybind.modemenu.drawings)
                        local cs = h:Create("Frame", {Vector2.new(1, 1), cr}, {
                            Size = h:Size(1, -2, 1, -2, cr),
                            Position = h:Position(0, 1, 0, 1, cr),
                            Color = k.light_contrast,
                            Visible = b3.open
                        }, keybind.modemenu.drawings)
                        local ck = h:Create("Image", {Vector2.new(0, 0), cs}, {
                            Size = h:Size(1, 0, 1, 0, cs),
                            Position = h:Position(0, 0, 0, 0, cs),
                            Transparency = 0.5,
                            Visible = b3.open
                        }, keybind.modemenu.drawings)
                        h:LoadImage(ck, "gradient", "https://i.imgur.com/5hmlrjX.png")
                        for F, G in pairs({"Always", "Toggle", "Hold"}) do
                            local ct = h:Create("TextLabel", {Vector2.new(cs.Size.X / 2, 15 * (F - 1)), cs}, {
                                Text = G,
                                Size = k.textsize,
                                Font = k.font,
                                Color = G == keybind.mode and k.accent or k.textcolor,
                                Center = true,
                                OutlineColor = k.textborder,
                                Position = h:Position(0.5, 0, 0, 15 * (F - 1), cs),
                                Visible = b3.open
                            }, keybind.modemenu.drawings)
                            keybind.modemenu.buttons[#keybind.modemenu.buttons + 1] = ct
                        end
                        ae.currentContent.frame = ax;
                        ae.currentContent.keybind = keybind
                    end
                end
            end;
            g.ended[#g.ended + 1] = function(aY)
                if keybind.active and keybind.mode == "Hold" then
                    if keybind.current[1] and keybind.current[2] then
                        if aY.KeyCode == Enum[keybind.current[1]][keybind.current[2]] or aY.UserInputType ==
                            Enum[keybind.current[1]][keybind.current[2]] then
                            keybind.active = false;
                            ae.keybindslist:Remove(aP or ab)
                            bz(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                        end
                    end
                end
            end;
            if bv and tostring(bv) ~= "" and tostring(bv) ~= " " and not g.pointers[tostring(bv)] then
                g.pointers[tostring(bv)] = keybind
            end
            bA.addedAxis = 40 + 4 + 2;
            ba:Update()
            return keybind
        end
        return bA
    end
    function j:Slider(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Slider"
        local by = aa.def or aa.Def or aa.default or aa.Default or 10;
        local cu = aa.min or aa.Min or aa.minimum or aa.Minimum or 0;
        local cv = aa.max or aa.Max or aa.maximum or aa.Maximum or 100;
        local cw = aa.suffix or aa.Suffix or aa.ending or aa.Ending or aa.prefix or aa.Prefix or aa.measurement or
                       aa.Measurement or ""
        local cx = aa.decimals or aa.Decimals or 1;
        cx = 1 / cx;
        local bv = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
        local bz = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
        end;
        by = math.clamp(by, cu, cv)
        local ae = self.window;
        local b3 = self.page;
        local ba = self;
        local cy = {
            min = cu,
            max = cv,
            sub = cw,
            decimals = cx,
            axis = ba.currentAxis,
            current = by,
            holding = false
        }
        local cz = h:Create("TextLabel", {Vector2.new(4, cy.axis), ba.section_frame}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 4, 0, cy.axis, ba.section_frame),
            Visible = b3.open
        }, ba.visibleContent)
        local cA = h:Create("Frame", {Vector2.new(4, cy.axis + 15), ba.section_frame}, {
            Size = h:Size(1, -8, 0, 12, ba.section_frame),
            Position = h:Position(0, 4, 0, cy.axis + 15, ba.section_frame),
            Color = k.outline,
            Visible = b3.open
        }, ba.visibleContent)
        local cB = h:Create("Frame", {Vector2.new(1, 1), cA}, {
            Size = h:Size(1, -2, 1, -2, cA),
            Position = h:Position(0, 1, 0, 1, cA),
            Color = k.inline,
            Visible = b3.open
        }, ba.visibleContent)
        local cC = h:Create("Frame", {Vector2.new(1, 1), cB}, {
            Size = h:Size(1, -2, 1, -2, cB),
            Position = h:Position(0, 1, 0, 1, cB),
            Color = k.light_contrast,
            Visible = b3.open
        }, ba.visibleContent)
        local cD = h:Create("Frame", {Vector2.new(1, 1), cB}, {
            Size = h:Size(0, cC.Size.X / (cy.max - cy.min) * (cy.current - cy.min), 1, -2, cB),
            Position = h:Position(0, 1, 0, 1, cB),
            Color = k.accent,
            Visible = b3.open
        }, ba.visibleContent)
        local cE = h:Create("Image", {Vector2.new(0, 0), cC}, {
            Size = h:Size(1, 0, 1, 0, cC),
            Position = h:Position(0, 0, 0, 0, cC),
            Transparency = 0.5,
            Visible = b3.open
        }, ba.visibleContent)
        local bp = h:GetTextBounds(ab, k.textsize, k.font)
        local cF = h:Create("TextLabel", {Vector2.new(cA.Size.X / 2, cA.Size.Y / 2 - bp.Y / 2), cA}, {
            Text = cy.current .. cy.sub .. "/" .. cy.max .. cy.sub,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            Center = true,
            OutlineColor = k.textborder,
            Position = h:Position(0.5, 0, 0, cA.Size.Y / 2 - bp.Y / 2, cA),
            Visible = b3.open
        }, ba.visibleContent)
        h:LoadImage(cE, "gradient", "https://i.imgur.com/5hmlrjX.png")
        function cy:Set(cG)
            cy.current = math.clamp(math.round(cG * cy.decimals) / cy.decimals, cy.min, cy.max)
            local cH = 1 - (cy.max - cy.current) / (cy.max - cy.min)
            cF.Text = cy.current .. cy.sub .. "/" .. cy.max .. cy.sub;
            cD.Size = h:Size(0, cH * cC.Size.X, 1, -2, cB)
            bz(cy.current)
        end
        function cy:Refresh()
            local S = h:MouseLocation()
            local cH = math.clamp(S.X - cD.Position.X, 0, cC.Size.X) / cC.Size.X;
            local cG = math.floor((cy.min + (cy.max - cy.min) * cH) * cy.decimals) / cy.decimals;
            cG = math.clamp(cG, cy.min, cy.max)
            cy:Set(cG)
        end
        function cy:Get()
            return cy.current
        end
        cy:Set(cy.current)
        g.began[#g.began + 1] = function(aY)
            if aY.UserInputType == Enum.UserInputType.MouseButton1 and cA.Visible and ae.isVisible and b3.open and
                h:MouseOverDrawing({ba.section_frame.Position.X, ba.section_frame.Position.Y + cy.axis,
                                    ba.section_frame.Position.X + ba.section_frame.Size.X,
                                    ba.section_frame.Position.Y + cy.axis + 27}) and not ae:IsOverContent() then
                cy.holding = true;
                cy:Refresh()
            end
        end;
        g.ended[#g.ended + 1] = function(aY)
            if aY.UserInputType == Enum.UserInputType.MouseButton1 and cy.holding and ae.isVisible then
                cy.holding = false
            end
        end;
        g.changed[#g.changed + 1] = function(aY)
            if cy.holding and ae.isVisible then
                cy:Refresh()
            end
        end;
        if bv and tostring(bv) ~= "" and tostring(bv) ~= " " and not g.pointers[tostring(bv)] then
            g.pointers[tostring(bv)] = cy
        end
        ba.currentAxis = ba.currentAxis + 27 + 4;
        ba:Update()
        return cy
    end
    function j:Button(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Button"
        local bv = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
        local bz = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
        end;
        local ae = self.window;
        local b3 = self.page;
        local ba = self;
        local cI = {
            axis = ba.currentAxis
        }
        local cJ = h:Create("Frame", {Vector2.new(4, cI.axis), ba.section_frame}, {
            Size = h:Size(1, -8, 0, 20, ba.section_frame),
            Position = h:Position(0, 4, 0, cI.axis, ba.section_frame),
            Color = k.outline,
            Visible = b3.open
        }, ba.visibleContent)
        local cK = h:Create("Frame", {Vector2.new(1, 1), cJ}, {
            Size = h:Size(1, -2, 1, -2, cJ),
            Position = h:Position(0, 1, 0, 1, cJ),
            Color = k.inline,
            Visible = b3.open
        }, ba.visibleContent)
        local cL = h:Create("Frame", {Vector2.new(1, 1), cK}, {
            Size = h:Size(1, -2, 1, -2, cK),
            Position = h:Position(0, 1, 0, 1, cK),
            Color = k.light_contrast,
            Visible = b3.open
        }, ba.visibleContent)
        local cM = h:Create("Image", {Vector2.new(0, 0), cL}, {
            Size = h:Size(1, 0, 1, 0, cL),
            Position = h:Position(0, 0, 0, 0, cL),
            Transparency = 0.5,
            Visible = b3.open
        }, ba.visibleContent)
        local ct = h:Create("TextLabel", {Vector2.new(cL.Size.X / 2, 1), cL}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Center = true,
            Position = h:Position(0.5, 0, 0, 1, cL),
            Visible = b3.open
        }, ba.visibleContent)
        h:LoadImage(cM, "gradient", "https://i.imgur.com/5hmlrjX.png")
        g.began[#g.began + 1] = function(aY)
            if aY.UserInputType == Enum.UserInputType.MouseButton1 and cJ.Visible and ae.isVisible and
                h:MouseOverDrawing({ba.section_frame.Position.X, ba.section_frame.Position.Y + cI.axis,
                                    ba.section_frame.Position.X + ba.section_frame.Size.X,
                                    ba.section_frame.Position.Y + cI.axis + 20}) and not ae:IsOverContent() then
                bz()
            end
        end;
        if bv and tostring(bv) ~= "" and tostring(bv) ~= " " and not g.pointers[tostring(bv)] then
            g.pointers[tostring(bv)] = cI
        end
        ba.currentAxis = ba.currentAxis + 20 + 4;
        ba:Update()
        return cI
    end
    function j:ButtonHolder(aa)
        local aa = aa or {}
        local cN = aa.buttons or aa.Buttons or {}
        local ae = self.window;
        local b3 = self.page;
        local ba = self;
        local cO = {
            buttons = {}
        }
        for F = 1, 2 do
            local cI = {
                axis = ba.currentAxis
            }
            local cJ = h:Create("Frame", {Vector2.new(F == 2 and ba.section_frame.Size.X / 2 + 2 or 4, cI.axis),
                                          ba.section_frame}, {
                Size = h:Size(0.5, -6, 0, 20, ba.section_frame),
                Position = h:Position(0, F == 2 and 2 or 4, 0, cI.axis, ba.section_frame),
                Color = k.outline,
                Visible = b3.open
            }, ba.visibleContent)
            local cK = h:Create("Frame", {Vector2.new(1, 1), cJ}, {
                Size = h:Size(1, -2, 1, -2, cJ),
                Position = h:Position(0, 1, 0, 1, cJ),
                Color = k.inline,
                Visible = b3.open
            }, ba.visibleContent)
            local cL = h:Create("Frame", {Vector2.new(1, 1), cK}, {
                Size = h:Size(1, -2, 1, -2, cK),
                Position = h:Position(0, 1, 0, 1, cK),
                Color = k.light_contrast,
                Visible = b3.open
            }, ba.visibleContent)
            local cM = h:Create("Image", {Vector2.new(0, 0), cL}, {
                Size = h:Size(1, 0, 1, 0, cL),
                Position = h:Position(0, 0, 0, 0, cL),
                Transparency = 0.5,
                Visible = b3.open
            }, ba.visibleContent)
            local ct = h:Create("TextLabel", {Vector2.new(cL.Size.X / 2, 1), cL}, {
                Text = cN[F][1],
                Size = k.textsize,
                Font = k.font,
                Color = k.textcolor,
                OutlineColor = k.textborder,
                Center = true,
                Position = h:Position(0.5, 0, 0, 1, cL),
                Visible = b3.open
            }, ba.visibleContent)
            h:LoadImage(cM, "gradient", "https://i.imgur.com/5hmlrjX.png")
            g.began[#g.began + 1] = function(aY)
                if aY.UserInputType == Enum.UserInputType.MouseButton1 and cJ.Visible and ae.isVisible and
                    h:MouseOverDrawing({ba.section_frame.Position.X + (F == 2 and ba.section_frame.Size.X / 2 or 0),
                                        ba.section_frame.Position.Y + cI.axis,
                                        ba.section_frame.Position.X + ba.section_frame.Size.X -
                        (F == 1 and ba.section_frame.Size.X / 2 or 0), ba.section_frame.Position.Y + cI.axis + 20}) and
                    not ae:IsOverContent() then
                    cN[F][2]()
                end
            end
        end
        ba.currentAxis = ba.currentAxis + 20 + 4;
        ba:Update()
    end
    function j:Dropdown(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Dropdown"
        local cP = aa.options or aa.Options or {"1", "2", "3"}
        local by = aa.def or aa.Def or aa.default or aa.Default or cP[1]
        local bv = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
        local bz = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
        end;
        local ae = self.window;
        local b3 = self.page;
        local ba = self;
        local au = {
            open = false,
            current = tostring(by),
            holder = {
                buttons = {},
                drawings = {}
            },
            axis = ba.currentAxis
        }
        local cQ = h:Create("Frame", {Vector2.new(4, au.axis + 15), ba.section_frame}, {
            Size = h:Size(1, -8, 0, 20, ba.section_frame),
            Position = h:Position(0, 4, 0, au.axis + 15, ba.section_frame),
            Color = k.outline,
            Visible = b3.open
        }, ba.visibleContent)
        local cR = h:Create("Frame", {Vector2.new(1, 1), cQ}, {
            Size = h:Size(1, -2, 1, -2, cQ),
            Position = h:Position(0, 1, 0, 1, cQ),
            Color = k.inline,
            Visible = b3.open
        }, ba.visibleContent)
        local cS = h:Create("Frame", {Vector2.new(1, 1), cR}, {
            Size = h:Size(1, -2, 1, -2, cR),
            Position = h:Position(0, 1, 0, 1, cR),
            Color = k.light_contrast,
            Visible = b3.open
        }, ba.visibleContent)
        local cT = h:Create("TextLabel", {Vector2.new(4, au.axis), ba.section_frame}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 4, 0, au.axis, ba.section_frame),
            Visible = b3.open
        }, ba.visibleContent)
        local cU = h:Create("Image", {Vector2.new(0, 0), cS}, {
            Size = h:Size(1, 0, 1, 0, cS),
            Position = h:Position(0, 0, 0, 0, cS),
            Transparency = 0.5,
            Visible = b3.open
        }, ba.visibleContent)
        local cV = h:Create("TextLabel", {Vector2.new(3, cS.Size.Y / 2 - 7), cS}, {
            Text = au.current,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 3, 0, cS.Size.Y / 2 - 7, cS),
            Visible = b3.open
        }, ba.visibleContent)
        local cW = h:Create("Image", {Vector2.new(cS.Size.X - 15, cS.Size.Y / 2 - 3), cS}, {
            Size = h:Size(0, 9, 0, 6, cS),
            Position = h:Position(1, -15, 0.5, -3, cS),
            Visible = b3.open
        }, ba.visibleContent)
        au["dropdown_image"] = cW;
        h:LoadImage(cW, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
        h:LoadImage(cU, "gradient", "https://i.imgur.com/5hmlrjX.png")
        function au:Update()
            if au.open and au.holder.inline then
                for F, G in pairs(au.holder.buttons) do
                    G[1].Color = G[1].Text == tostring(au.current) and k.accent or k.textcolor;
                    G[1].Position = h:Position(0, G[1].Text == tostring(au.current) and 8 or 6, 0, 2, G[2])
                    h:UpdateOffset(G[1], {Vector2.new(G[1].Text == tostring(au.current) and 8 or 6, 2), G[2]})
                end
            end
        end
        function au:Set(cG)
            if typeof(cG) == "string" and table.find(cP, cG) then
                au.current = cG;
                cV.Text = cG
            end
        end
        function au:Get()
            return au.current
        end
        g.began[#g.began + 1] = function(aY)
            if aY.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and cQ.Visible then
                if au.open and au.holder.inline and
                    h:MouseOverDrawing({au.holder.inline.Position.X, au.holder.inline.Position.Y,
                                        au.holder.inline.Position.X + au.holder.inline.Size.X,
                                        au.holder.inline.Position.Y + au.holder.inline.Size.Y}) then
                    for F, G in pairs(au.holder.buttons) do
                        if h:MouseOverDrawing({G[2].Position.X, G[2].Position.Y, G[2].Position.X + G[2].Size.X,
                                               G[2].Position.Y + G[2].Size.Y}) and G[1].Text ~= au.current then
                            au.current = G[1].Text;
                            cV.Text = au.current;
                            au:Update()
                            bz(au.current)
                        end
                    end
                elseif h:MouseOverDrawing({ba.section_frame.Position.X, ba.section_frame.Position.Y + au.axis,
                                           ba.section_frame.Position.X + ba.section_frame.Size.X,
                                           ba.section_frame.Position.Y + au.axis + 15 + 20}) and not ae:IsOverContent() then
                    if not au.open then
                        ae:CloseContent()
                        au.open = not au.open;
                        h:LoadImage(cW, "arrow_up", "https://i.imgur.com/SL9cbQp.png")
                        local cX = h:Create("Frame", {Vector2.new(0, 19), cQ}, {
                            Size = h:Size(1, 0, 0, 3 + #cP * 19, cQ),
                            Position = h:Position(0, 0, 0, 19, cQ),
                            Color = k.outline,
                            Visible = b3.open
                        }, au.holder.drawings)
                        au.holder.outline = cX;
                        local cY = h:Create("Frame", {Vector2.new(1, 1), cX}, {
                            Size = h:Size(1, -2, 1, -2, cX),
                            Position = h:Position(0, 1, 0, 1, cX),
                            Color = k.inline,
                            Visible = b3.open
                        }, au.holder.drawings)
                        au.holder.inline = cY;
                        for F, G in pairs(cP) do
                            local cZ = h:Create("Frame", {Vector2.new(1, 1 + 19 * (F - 1)), cY}, {
                                Size = h:Size(1, -2, 0, 18, cY),
                                Position = h:Position(0, 1, 0, 1 + 19 * (F - 1), cY),
                                Color = k.light_contrast,
                                Visible = b3.open
                            }, au.holder.drawings)
                            local cV = h:Create("TextLabel", {Vector2.new(G == tostring(au.current) and 8 or 6, 2), cZ},
                                {
                                    Text = G,
                                    Size = k.textsize,
                                    Font = k.font,
                                    Color = G == tostring(au.current) and k.accent or k.textcolor,
                                    OutlineColor = k.textborder,
                                    Position = h:Position(0, G == tostring(au.current) and 8 or 6, 0, 2, cZ),
                                    Visible = b3.open
                                }, au.holder.drawings)
                            au.holder.buttons[#au.holder.buttons + 1] = {cV, cZ}
                        end
                        ae.currentContent.frame = cY;
                        ae.currentContent.dropdown = au
                    else
                        au.open = not au.open;
                        h:LoadImage(cW, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                        for F, G in pairs(au.holder.drawings) do
                            h:Remove(G)
                        end
                        au.holder.drawings = {}
                        au.holder.buttons = {}
                        au.holder.inline = nil;
                        ae.currentContent.frame = nil;
                        ae.currentContent.dropdown = nil
                    end
                else
                    if au.open then
                        au.open = not au.open;
                        h:LoadImage(cW, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                        for F, G in pairs(au.holder.drawings) do
                            h:Remove(G)
                        end
                        au.holder.drawings = {}
                        au.holder.buttons = {}
                        au.holder.inline = nil;
                        ae.currentContent.frame = nil;
                        ae.currentContent.dropdown = nil
                    end
                end
            elseif aY.UserInputType == Enum.UserInputType.MouseButton1 and au.open then
                au.open = not au.open;
                h:LoadImage(cW, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                for F, G in pairs(au.holder.drawings) do
                    h:Remove(G)
                end
                au.holder.drawings = {}
                au.holder.buttons = {}
                au.holder.inline = nil;
                ae.currentContent.frame = nil;
                ae.currentContent.dropdown = nil
            end
        end;
        if bv and tostring(bv) ~= "" and tostring(bv) ~= " " and not g.pointers[tostring(bv)] then
            g.pointers[tostring(bv)] = au
        end
        ba.currentAxis = ba.currentAxis + 35 + 4;
        ba:Update()
        return au
    end
    function j:Multibox(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Multibox"
        local cP = aa.options or aa.Options or {"1", "2", "3"}
        local by = aa.def or aa.Def or aa.default or aa.Default or {cP[1]}
        local bv = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
        local bz = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
        end;
        local cu = aa.min or aa.Min or aa.minimum or aa.Minimum or 0;
        local ae = self.window;
        local b3 = self.page;
        local ba = self;
        local av = {
            open = false,
            current = by,
            holder = {
                buttons = {},
                drawings = {}
            },
            axis = ba.currentAxis
        }
        local c_ = h:Create("Frame", {Vector2.new(4, av.axis + 15), ba.section_frame}, {
            Size = h:Size(1, -8, 0, 20, ba.section_frame),
            Position = h:Position(0, 4, 0, av.axis + 15, ba.section_frame),
            Color = k.outline,
            Visible = b3.open
        }, ba.visibleContent)
        local d0 = h:Create("Frame", {Vector2.new(1, 1), c_}, {
            Size = h:Size(1, -2, 1, -2, c_),
            Position = h:Position(0, 1, 0, 1, c_),
            Color = k.inline,
            Visible = b3.open
        }, ba.visibleContent)
        local d1 = h:Create("Frame", {Vector2.new(1, 1), d0}, {
            Size = h:Size(1, -2, 1, -2, d0),
            Position = h:Position(0, 1, 0, 1, d0),
            Color = k.light_contrast,
            Visible = b3.open
        }, ba.visibleContent)
        local d2 = h:Create("TextLabel", {Vector2.new(4, av.axis), ba.section_frame}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 4, 0, av.axis, ba.section_frame),
            Visible = b3.open
        }, ba.visibleContent)
        local d3 = h:Create("Image", {Vector2.new(0, 0), d1}, {
            Size = h:Size(1, 0, 1, 0, d1),
            Position = h:Position(0, 0, 0, 0, d1),
            Transparency = 0.5,
            Visible = b3.open
        }, ba.visibleContent)
        local d4 = h:Create("TextLabel", {Vector2.new(3, d1.Size.Y / 2 - 7), d1}, {
            Text = "",
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 3, 0, d1.Size.Y / 2 - 7, d1),
            Visible = b3.open
        }, ba.visibleContent)
        local d5 = h:Create("Image", {Vector2.new(d1.Size.X - 15, d1.Size.Y / 2 - 3), d1}, {
            Size = h:Size(0, 9, 0, 6, d1),
            Position = h:Position(1, -15, 0.5, -3, d1),
            Visible = b3.open
        }, ba.visibleContent)
        av["multibox_image"] = d5;
        h:LoadImage(d5, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
        h:LoadImage(d3, "gradient", "https://i.imgur.com/5hmlrjX.png")
        function av:Update()
            if av.open and av.holder.inline then
                for F, G in pairs(av.holder.buttons) do
                    G[1].Color = table.find(av.current, G[1].Text) and k.accent or k.textcolor;
                    G[1].Position = h:Position(0, table.find(av.current, G[1].Text) and 8 or 6, 0, 2, G[2])
                    h:UpdateOffset(G[1], {Vector2.new(table.find(av.current, G[1].Text) and 8 or 6, 2), G[2]})
                end
            end
        end
        function av:Serialize(cn)
            local K = ""
            for F, G in pairs(cn) do
                K = K .. G .. ", "
            end
            return string.sub(K, 0, #K - 2)
        end
        function av:Resort(cn, d6)
            local d7 = {}
            for F, G in pairs(d6) do
                if table.find(cn, G) then
                    d7[#d7 + 1] = G
                end
            end
            return d7
        end
        function av:Set(cn)
            if typeof(cn) == "table" then
                av.current = cn;
                d4.Text = av:Serialize(av:Resort(av.current, cP))
            end
        end
        function av:Get()
            return av.current
        end
        d4.Text = av:Serialize(av:Resort(av.current, cP))
        g.began[#g.began + 1] = function(aY)
            if aY.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and c_.Visible then
                if av.open and av.holder.inline and
                    h:MouseOverDrawing({av.holder.inline.Position.X, av.holder.inline.Position.Y,
                                        av.holder.inline.Position.X + av.holder.inline.Size.X,
                                        av.holder.inline.Position.Y + av.holder.inline.Size.Y}) then
                    for F, G in pairs(av.holder.buttons) do
                        if h:MouseOverDrawing({G[2].Position.X, G[2].Position.Y, G[2].Position.X + G[2].Size.X,
                                               G[2].Position.Y + G[2].Size.Y}) and G[1].Text ~= av.current then
                            if not table.find(av.current, G[1].Text) then
                                av.current[#av.current + 1] = G[1].Text;
                                d4.Text = av:Serialize(av:Resort(av.current, cP))
                                av:Update()
                                bz(av.current)
                            else
                                if #av.current > cu then
                                    table.remove(av.current, table.find(av.current, G[1].Text))
                                    d4.Text = av:Serialize(av:Resort(av.current, cP))
                                    av:Update()
                                end
                            end
                        end
                    end
                elseif h:MouseOverDrawing({ba.section_frame.Position.X, ba.section_frame.Position.Y + av.axis,
                                           ba.section_frame.Position.X + ba.section_frame.Size.X,
                                           ba.section_frame.Position.Y + av.axis + 15 + 20}) and not ae:IsOverContent() then
                    if not av.open then
                        ae:CloseContent()
                        av.open = not av.open;
                        h:LoadImage(d5, "arrow_up", "https://i.imgur.com/SL9cbQp.png")
                        local d8 = h:Create("Frame", {Vector2.new(0, 19), c_}, {
                            Size = h:Size(1, 0, 0, 3 + #cP * 19, c_),
                            Position = h:Position(0, 0, 0, 19, c_),
                            Color = k.outline,
                            Visible = b3.open
                        }, av.holder.drawings)
                        av.holder.outline = d8;
                        local d9 = h:Create("Frame", {Vector2.new(1, 1), d8}, {
                            Size = h:Size(1, -2, 1, -2, d8),
                            Position = h:Position(0, 1, 0, 1, d8),
                            Color = k.inline,
                            Visible = b3.open
                        }, av.holder.drawings)
                        av.holder.inline = d9;
                        for F, G in pairs(cP) do
                            local da = h:Create("Frame", {Vector2.new(1, 1 + 19 * (F - 1)), d9}, {
                                Size = h:Size(1, -2, 0, 18, d9),
                                Position = h:Position(0, 1, 0, 1 + 19 * (F - 1), d9),
                                Color = k.light_contrast,
                                Visible = b3.open
                            }, av.holder.drawings)
                            local d4 = h:Create("TextLabel", {Vector2.new(table.find(av.current, G) and 8 or 6, 2), da},
                                {
                                    Text = G,
                                    Size = k.textsize,
                                    Font = k.font,
                                    Color = table.find(av.current, G) and k.accent or k.textcolor,
                                    OutlineColor = k.textborder,
                                    Position = h:Position(0, table.find(av.current, G) and 8 or 6, 0, 2, da),
                                    Visible = b3.open
                                }, av.holder.drawings)
                            av.holder.buttons[#av.holder.buttons + 1] = {d4, da}
                        end
                        ae.currentContent.frame = d9;
                        ae.currentContent.multibox = av
                    else
                        av.open = not av.open;
                        h:LoadImage(d5, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                        for F, G in pairs(av.holder.drawings) do
                            h:Remove(G)
                        end
                        av.holder.drawings = {}
                        av.holder.buttons = {}
                        av.holder.inline = nil;
                        ae.currentContent.frame = nil;
                        ae.currentContent.multibox = nil
                    end
                else
                    if av.open then
                        av.open = not av.open;
                        h:LoadImage(d5, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                        for F, G in pairs(av.holder.drawings) do
                            h:Remove(G)
                        end
                        av.holder.drawings = {}
                        av.holder.buttons = {}
                        av.holder.inline = nil;
                        ae.currentContent.frame = nil;
                        ae.currentContent.multibox = nil
                    end
                end
            elseif aY.UserInputType == Enum.UserInputType.MouseButton1 and av.open then
                av.open = not av.open;
                h:LoadImage(d5, "arrow_down", "https://i.imgur.com/tVqy0nL.png")
                for F, G in pairs(av.holder.drawings) do
                    h:Remove(G)
                end
                av.holder.drawings = {}
                av.holder.buttons = {}
                av.holder.inline = nil;
                ae.currentContent.frame = nil;
                ae.currentContent.multibox = nil
            end
        end;
        if bv and tostring(bv) ~= "" and tostring(bv) ~= " " and not g.pointers[tostring(bv)] then
            g.pointers[tostring(bv)] = av
        end
        ba.currentAxis = ba.currentAxis + 35 + 4;
        ba:Update()
        return av
    end
    function j:Keybind(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Keybind"
        local by = aa.def or aa.Def or aa.default or aa.Default or nil;
        local bv = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
        local cg = aa.mode or aa.Mode or "Always"
        local aP = aa.keybindname or aa.keybindName or aa.Keybindname or aa.KeybindName or nil;
        local bz = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
        end;
        local ae = self.window;
        local b3 = self.page;
        local ba = self;
        local keybind = {
            keybindname = aP or ab,
            axis = ba.currentAxis,
            current = {},
            selecting = false,
            mode = cg,
            open = false,
            modemenu = {
                buttons = {},
                drawings = {}
            },
            active = false
        }
        local ch = {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "A", "S", "D", "F", "G", "H", "J", "K", "L", "Z",
                    "X", "C", "V", "B", "N", "M", "One", "Two", "Three", "Four", "Five", "Six", "Seveen", "Eight",
                    "Nine", "0", "Insert", "Tab", "Home", "End", "LeftAlt", "LeftControl", "LeftShift", "RightAlt",
                    "RightControl", "RightShift", "CapsLock"}
        local ci = {"MouseButton1", "MouseButton2", "MouseButton3"}
        local cj = {
            ["MouseButton1"] = "MB1",
            ["MouseButton2"] = "MB2",
            ["MouseButton3"] = "MB3",
            ["Insert"] = "Ins",
            ["LeftAlt"] = "LAlt",
            ["LeftControl"] = "LC",
            ["LeftShift"] = "LS",
            ["RightAlt"] = "RAlt",
            ["RightControl"] = "RC",
            ["RightShift"] = "RS",
            ["CapsLock"] = "Caps"
        }
        local aS = h:Create("Frame", {Vector2.new(ba.section_frame.Size.X - (40 + 4), keybind.axis), ba.section_frame},
            {
                Size = h:Size(0, 40, 0, 17),
                Position = h:Position(1, -(40 + 4), 0, keybind.axis, ba.section_frame),
                Color = k.outline,
                Visible = b3.open
            }, ba.visibleContent)
        local aT = h:Create("Frame", {Vector2.new(1, 1), aS}, {
            Size = h:Size(1, -2, 1, -2, aS),
            Position = h:Position(0, 1, 0, 1, aS),
            Color = k.inline,
            Visible = b3.open
        }, ba.visibleContent)
        local aU = h:Create("Frame", {Vector2.new(1, 1), aT}, {
            Size = h:Size(1, -2, 1, -2, aT),
            Position = h:Position(0, 1, 0, 1, aT),
            Color = k.light_contrast,
            Visible = b3.open
        }, ba.visibleContent)
        local aV = h:Create("TextLabel", {Vector2.new(4, keybind.axis + 17 / 2 -
            h:GetTextBounds(ab, k.textsize, k.font).Y / 2), ba.section_frame}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 4, 0, keybind.axis + 17 / 2 - h:GetTextBounds(ab, k.textsize, k.font).Y / 2,
                ba.section_frame),
            Visible = b3.open
        }, ba.visibleContent)
        local ck = h:Create("Image", {Vector2.new(0, 0), aU}, {
            Size = h:Size(1, 0, 1, 0, aU),
            Position = h:Position(0, 0, 0, 0, aU),
            Transparency = 0.5,
            Visible = b3.open
        }, ba.visibleContent)
        local aW = h:Create("TextLabel", {Vector2.new(aS.Size.X / 2, 1), aS}, {
            Text = "...",
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Center = true,
            Position = h:Position(0.5, 0, 1, 0, aS),
            Visible = b3.open
        }, ba.visibleContent)
        h:LoadImage(ck, "gradient", "https://i.imgur.com/5hmlrjX.png")
        function keybind:Shorten(string)
            for F, G in pairs(cj) do
                string = string.gsub(string, F, G)
            end
            return string
        end
        function keybind:Change(cl)
            cl = cl or "..."
            local cm = {}
            if cl.EnumType then
                if cl.EnumType == Enum.KeyCode or cl.EnumType == Enum.UserInputType then
                    if table.find(ch, cl.Name) or table.find(ci, cl.Name) then
                        cm = {cl.EnumType == Enum.KeyCode and "KeyCode" or "UserInputType", cl.Name}
                        keybind.current = cm;
                        aW.Text = #keybind.current > 0 and keybind:Shorten(keybind.current[2]) or "..."
                        return true
                    end
                end
            end
            return false
        end
        function keybind:Get()
            return keybind.current
        end
        function keybind:Active()
            return keybind.active
        end
        function keybind:Reset()
            for F, G in pairs(keybind.modemenu.buttons) do
                G.Color = G.Text == keybind.mode and k.accent or k.textcolor
            end
            keybind.active = keybind.mode == "Always" and true or false;
            if keybind.current[1] and keybind.current[2] then
                bz(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
            end
        end
        keybind:Change(by)
        g.began[#g.began + 1] = function(aY)
            if keybind.current[1] and keybind.current[2] then
                if aY.KeyCode == Enum[keybind.current[1]][keybind.current[2]] or aY.UserInputType ==
                    Enum[keybind.current[1]][keybind.current[2]] then
                    if keybind.mode == "Hold" then
                        keybind.active = true;
                        if keybind.active then
                            ae.keybindslist:Add(aP or ab, aW.Text)
                        else
                            ae.keybindslist:Remove(aP or ab)
                        end
                        bz(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                    elseif keybind.mode == "Toggle" then
                        keybind.active = not keybind.active;
                        if keybind.active then
                            ae.keybindslist:Add(aP or ab, aW.Text)
                        else
                            ae.keybindslist:Remove(aP or ab)
                        end
                        bz(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                    end
                end
            end
            if keybind.selecting and ae.isVisible then
                local cp = keybind:Change(aY.KeyCode.Name ~= "Unknown" and aY.KeyCode or aY.UserInputType)
                if cp then
                    keybind.selecting = false;
                    keybind.active = keybind.mode == "Always" and true or false;
                    aU.Color = k.light_contrast;
                    ae.keybindslist:Remove(aP or ab)
                    bz(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                end
            end
            if not ae.isVisible and keybind.selecting then
                keybind.selecting = false;
                aU.Color = k.light_contrast
            end
            if aY.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and aS.Visible then
                if h:MouseOverDrawing({ba.section_frame.Position.X, ba.section_frame.Position.Y + keybind.axis,
                                       ba.section_frame.Position.X + ba.section_frame.Size.X,
                                       ba.section_frame.Position.Y + keybind.axis + 17}) and not ae:IsOverContent() and
                    not keybind.selecting then
                    keybind.selecting = true;
                    aU.Color = k.dark_contrast
                end
                if keybind.open and keybind.modemenu.frame then
                    if h:MouseOverDrawing({keybind.modemenu.frame.Position.X, keybind.modemenu.frame.Position.Y,
                                           keybind.modemenu.frame.Position.X + keybind.modemenu.frame.Size.X,
                                           keybind.modemenu.frame.Position.Y + keybind.modemenu.frame.Size.Y}) then
                        local cq = false;
                        for F, G in pairs(keybind.modemenu.buttons) do
                            if h:MouseOverDrawing({keybind.modemenu.frame.Position.X,
                                                   keybind.modemenu.frame.Position.Y + 15 * (F - 1),
                                                   keybind.modemenu.frame.Position.X + keybind.modemenu.frame.Size.X,
                                                   keybind.modemenu.frame.Position.Y + 15 * (F - 1) + 15}) then
                                keybind.mode = G.Text;
                                cq = true
                            end
                        end
                        if cq then
                            keybind:Reset()
                        end
                    else
                        keybind.open = not keybind.open;
                        for F, G in pairs(keybind.modemenu.drawings) do
                            h:Remove(G)
                        end
                        keybind.modemenu.drawings = {}
                        keybind.modemenu.buttons = {}
                        keybind.modemenu.frame = nil;
                        ae.currentContent.frame = nil;
                        ae.currentContent.keybind = nil
                    end
                end
            end
            if aY.UserInputType == Enum.UserInputType.MouseButton2 and ae.isVisible and aS.Visible then
                if h:MouseOverDrawing({ba.section_frame.Position.X, ba.section_frame.Position.Y + keybind.axis,
                                       ba.section_frame.Position.X + ba.section_frame.Size.X,
                                       ba.section_frame.Position.Y + keybind.axis + 17}) and not ae:IsOverContent() and
                    not keybind.selecting then
                    ae:CloseContent()
                    keybind.open = not keybind.open;
                    local ax = h:Create("Frame", {Vector2.new(aS.Size.X + 2, 0), aS}, {
                        Size = h:Size(0, 64, 0, 49),
                        Position = h:Position(1, 2, 0, 0, aS),
                        Color = k.outline,
                        Visible = b3.open
                    }, keybind.modemenu.drawings)
                    keybind.modemenu.frame = ax;
                    local cr = h:Create("Frame", {Vector2.new(1, 1), ax}, {
                        Size = h:Size(1, -2, 1, -2, ax),
                        Position = h:Position(0, 1, 0, 1, ax),
                        Color = k.inline,
                        Visible = b3.open
                    }, keybind.modemenu.drawings)
                    local cs = h:Create("Frame", {Vector2.new(1, 1), cr}, {
                        Size = h:Size(1, -2, 1, -2, cr),
                        Position = h:Position(0, 1, 0, 1, cr),
                        Color = k.light_contrast,
                        Visible = b3.open
                    }, keybind.modemenu.drawings)
                    local ck = h:Create("Image", {Vector2.new(0, 0), cs}, {
                        Size = h:Size(1, 0, 1, 0, cs),
                        Position = h:Position(0, 0, 0, 0, cs),
                        Transparency = 0.5,
                        Visible = b3.open
                    }, keybind.modemenu.drawings)
                    h:LoadImage(ck, "gradient", "https://i.imgur.com/5hmlrjX.png")
                    for F, G in pairs({"Always", "Toggle", "Hold"}) do
                        local ct = h:Create("TextLabel", {Vector2.new(cs.Size.X / 2, 15 * (F - 1)), cs}, {
                            Text = G,
                            Size = k.textsize,
                            Font = k.font,
                            Color = G == keybind.mode and k.accent or k.textcolor,
                            Center = true,
                            OutlineColor = k.textborder,
                            Position = h:Position(0.5, 0, 0, 15 * (F - 1), cs),
                            Visible = b3.open
                        }, keybind.modemenu.drawings)
                        keybind.modemenu.buttons[#keybind.modemenu.buttons + 1] = ct
                    end
                    ae.currentContent.frame = ax;
                    ae.currentContent.keybind = keybind
                end
            end
        end;
        g.ended[#g.ended + 1] = function(aY)
            if keybind.active and keybind.mode == "Hold" then
                if keybind.current[1] and keybind.current[2] then
                    if aY.KeyCode == Enum[keybind.current[1]][keybind.current[2]] or aY.UserInputType ==
                        Enum[keybind.current[1]][keybind.current[2]] then
                        keybind.active = false;
                        ae.keybindslist:Remove(aP or ab)
                        bz(Enum[keybind.current[1]][keybind.current[2]], keybind.active)
                    end
                end
            end
        end;
        if bv and tostring(bv) ~= "" and tostring(bv) ~= " " and not g.pointers[tostring(bv)] then
            g.pointers[tostring(bv)] = keybind
        end
        ba.currentAxis = ba.currentAxis + 17 + 4;
        ba:Update()
        return keybind
    end
    function j:Colorpicker(aa)
        local aa = aa or {}
        local ab = aa.name or aa.Name or aa.title or aa.Title or "New Colorpicker"
        local bH = aa.info or aa.Info or ab;
        local by = aa.def or aa.Def or aa.default or aa.Default or Color3.fromRGB(255, 0, 0)
        local bI = aa.transparency or aa.Transparency or aa.transp or aa.Transp or aa.alpha or aa.Alpha or nil;
        local bv = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
        local bz = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
        end;
        local ae = self.window;
        local b3 = self.page;
        local ba = self;
        local bJ, bK, bL = by:ToHSV()
        local aw = {
            axis = ba.currentAxis,
            secondColorpicker = false,
            current = {bJ, bK, bL, bI or 0},
            holding = {
                picker = false,
                huepicker = false,
                transparency = false
            },
            holder = {
                inline = nil,
                picker = nil,
                picker_cursor = nil,
                huepicker = nil,
                huepicker_cursor = {},
                transparency = nil,
                transparencybg = nil,
                transparency_cursor = {},
                drawings = {}
            }
        }
        local bM = h:Create("Frame", {Vector2.new(ba.section_frame.Size.X - (30 + 4), aw.axis), ba.section_frame}, {
            Size = h:Size(0, 30, 0, 15),
            Position = h:Position(1, -(30 + 4), 0, aw.axis, ba.section_frame),
            Color = k.outline,
            Visible = b3.open
        }, ba.visibleContent)
        local bN = h:Create("Frame", {Vector2.new(1, 1), bM}, {
            Size = h:Size(1, -2, 1, -2, bM),
            Position = h:Position(0, 1, 0, 1, bM),
            Color = k.inline,
            Visible = b3.open
        }, ba.visibleContent)
        local bO;
        if bI then
            bO = h:Create("Image", {Vector2.new(1, 1), bN}, {
                Size = h:Size(1, -2, 1, -2, bN),
                Position = h:Position(0, 1, 0, 1, bN),
                Visible = b3.open
            }, ba.visibleContent)
        end
        local bP = h:Create("Frame", {Vector2.new(1, 1), bN}, {
            Size = h:Size(1, -2, 1, -2, bN),
            Position = h:Position(0, 1, 0, 1, bN),
            Color = by,
            Transparency = bI and 1 - bI or 1,
            Visible = b3.open
        }, ba.visibleContent)
        local bQ = h:Create("Image", {Vector2.new(0, 0), bP}, {
            Size = h:Size(1, 0, 1, 0, bP),
            Position = h:Position(0, 0, 0, 0, bP),
            Transparency = 0.5,
            Visible = b3.open
        }, ba.visibleContent)
        local bY = h:Create("TextLabel", {Vector2.new(4,
            aw.axis + 15 / 2 - h:GetTextBounds(ab, k.textsize, k.font).Y / 2), ba.section_frame}, {
            Text = ab,
            Size = k.textsize,
            Font = k.font,
            Color = k.textcolor,
            OutlineColor = k.textborder,
            Position = h:Position(0, 4, 0, aw.axis + 15 / 2 - h:GetTextBounds(ab, k.textsize, k.font).Y / 2,
                ba.section_frame),
            Visible = b3.open
        }, ba.visibleContent)
        if bI then
            h:LoadImage(bO, "cptransp", "https://i.imgur.com/IIPee2A.png")
        end
        h:LoadImage(bQ, "gradient", "https://i.imgur.com/5hmlrjX.png")
        function aw:Set(bR, bS)
            if typeof(bR) == "table" then
                aw.current = bR;
                bP.Color = Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3])
                bP.Transparency = 1 - aw.current[4]
                bz(Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3]), aw.current[4])
            elseif typeof(bR) == "color3" then
                local bT, b2, G = bR:ToHSV()
                aw.current = {bT, b2, G, bS or 0}
                bP.Color = Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3])
                bP.Transparency = 1 - aw.current[4]
                bz(Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3]), aw.current[4])
            end
        end
        function aw:Refresh()
            local S = h:MouseLocation()
            if aw.open and aw.holder.picker and aw.holding.picker then
                aw.current[2] = math.clamp(S.X - aw.holder.picker.Position.X, 0, aw.holder.picker.Size.X) /
                                    aw.holder.picker.Size.X;
                aw.current[3] = 1 - math.clamp(S.Y - aw.holder.picker.Position.Y, 0, aw.holder.picker.Size.Y) /
                                    aw.holder.picker.Size.Y;
                aw.holder.picker_cursor.Position =
                    h:Position(aw.current[2], -3, 1 - aw.current[3], -3, aw.holder.picker)
                h:UpdateOffset(aw.holder.picker_cursor,
                    {Vector2.new(aw.holder.picker.Size.X * aw.current[2] - 3,
                        aw.holder.picker.Size.Y * (1 - aw.current[3]) - 3), aw.holder.picker})
                if aw.holder.transparencybg then
                    aw.holder.transparencybg.Color = Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3])
                end
            elseif aw.open and aw.holder.huepicker and aw.holding.huepicker then
                aw.current[1] = math.clamp(S.Y - aw.holder.huepicker.Position.Y, 0, aw.holder.huepicker.Size.Y) /
                                    aw.holder.huepicker.Size.Y;
                aw.holder.huepicker_cursor[1].Position = h:Position(0, -3, aw.current[1], -3, aw.holder.huepicker)
                aw.holder.huepicker_cursor[2].Position = h:Position(0, 1, 0, 1, aw.holder.huepicker_cursor[1])
                aw.holder.huepicker_cursor[3].Position = h:Position(0, 1, 0, 1, aw.holder.huepicker_cursor[2])
                aw.holder.huepicker_cursor[3].Color = Color3.fromHSV(aw.current[1], 1, 1)
                h:UpdateOffset(aw.holder.huepicker_cursor[1],
                    {Vector2.new(-3, aw.holder.huepicker.Size.Y * aw.current[1] - 3), aw.holder.huepicker})
                aw.holder.background.Color = Color3.fromHSV(aw.current[1], 1, 1)
                if aw.holder.transparency_cursor and aw.holder.transparency_cursor[3] then
                    aw.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - aw.current[4])
                end
                if aw.holder.transparencybg then
                    aw.holder.transparencybg.Color = Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3])
                end
            elseif aw.open and aw.holder.transparency and aw.holding.transparency then
                aw.current[4] = 1 -
                                    math.clamp(S.X - aw.holder.transparency.Position.X, 0, aw.holder.transparency.Size.X) /
                                    aw.holder.transparency.Size.X;
                aw.holder.transparency_cursor[1].Position = h:Position(1 - aw.current[4], -3, 0, -3,
                    aw.holder.transparency)
                aw.holder.transparency_cursor[2].Position = h:Position(0, 1, 0, 1, aw.holder.transparency_cursor[1])
                aw.holder.transparency_cursor[3].Position = h:Position(0, 1, 0, 1, aw.holder.transparency_cursor[2])
                aw.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - aw.current[4])
                bP.Transparency = 1 - aw.current[4]
                h:UpdateTransparency(bP, 1 - aw.current[4])
                h:UpdateOffset(aw.holder.transparency_cursor[1], {Vector2.new(
                    aw.holder.transparency.Size.X * (1 - aw.current[4]) - 3, -3), aw.holder.transparency})
                aw.holder.background.Color = Color3.fromHSV(aw.current[1], 1, 1)
            end
            aw:Set(aw.current)
        end
        function aw:Get()
            return Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3])
        end
        g.began[#g.began + 1] = function(aY)
            if aY.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and bM.Visible then
                if aw.open and aw.holder.inline and
                    h:MouseOverDrawing({aw.holder.inline.Position.X, aw.holder.inline.Position.Y,
                                        aw.holder.inline.Position.X + aw.holder.inline.Size.X,
                                        aw.holder.inline.Position.Y + aw.holder.inline.Size.Y}) then
                    if aw.holder.picker and
                        h:MouseOverDrawing({aw.holder.picker.Position.X - 2, aw.holder.picker.Position.Y - 2,
                                            aw.holder.picker.Position.X - 2 + aw.holder.picker.Size.X + 4,
                                            aw.holder.picker.Position.Y - 2 + aw.holder.picker.Size.Y + 4}) then
                        aw.holding.picker = true;
                        aw:Refresh()
                    elseif aw.holder.huepicker and
                        h:MouseOverDrawing({aw.holder.huepicker.Position.X - 2, aw.holder.huepicker.Position.Y - 2,
                                            aw.holder.huepicker.Position.X - 2 + aw.holder.huepicker.Size.X + 4,
                                            aw.holder.huepicker.Position.Y - 2 + aw.holder.huepicker.Size.Y + 4}) then
                        aw.holding.huepicker = true;
                        aw:Refresh()
                    elseif aw.holder.transparency and
                        h:MouseOverDrawing(
                            {aw.holder.transparency.Position.X - 2, aw.holder.transparency.Position.Y - 2,
                             aw.holder.transparency.Position.X - 2 + aw.holder.transparency.Size.X + 4,
                             aw.holder.transparency.Position.Y - 2 + aw.holder.transparency.Size.Y + 4}) then
                        aw.holding.transparency = true;
                        aw:Refresh()
                    end
                elseif h:MouseOverDrawing({ba.section_frame.Position.X, ba.section_frame.Position.Y + aw.axis,
                                           ba.section_frame.Position.X + ba.section_frame.Size.X -
                    (aw.secondColorpicker and 30 + 4 or 0), ba.section_frame.Position.Y + aw.axis + 15}) and
                    not ae:IsOverContent() then
                    if not aw.open then
                        ae:CloseContent()
                        aw.open = not aw.open;
                        local bU = h:Create("Frame", {Vector2.new(4, aw.axis + 19), ba.section_frame}, {
                            Size = h:Size(1, -8, 0, bI and 219 or 200, ba.section_frame),
                            Position = h:Position(0, 4, 0, aw.axis + 19, ba.section_frame),
                            Color = k.outline
                        }, aw.holder.drawings)
                        aw.holder.inline = bU;
                        local bV = h:Create("Frame", {Vector2.new(1, 1), bU}, {
                            Size = h:Size(1, -2, 1, -2, bU),
                            Position = h:Position(0, 1, 0, 1, bU),
                            Color = k.inline
                        }, aw.holder.drawings)
                        local bW = h:Create("Frame", {Vector2.new(1, 1), bV}, {
                            Size = h:Size(1, -2, 1, -2, bV),
                            Position = h:Position(0, 1, 0, 1, bV),
                            Color = k.dark_contrast
                        }, aw.holder.drawings)
                        local bX = h:Create("Frame", {Vector2.new(0, 0), bW}, {
                            Size = h:Size(1, 0, 0, 2, bW),
                            Position = h:Position(0, 0, 0, 0, bW),
                            Color = k.accent
                        }, aw.holder.drawings)
                        local bY = h:Create("TextLabel", {Vector2.new(4, 2), bW}, {
                            Text = bH,
                            Size = k.textsize,
                            Font = k.font,
                            Color = k.textcolor,
                            OutlineColor = k.textborder,
                            Position = h:Position(0, 4, 0, 2, bW)
                        }, aw.holder.drawings)
                        local bZ = h:Create("Frame", {Vector2.new(4, 17), bW}, {
                            Size = h:Size(1, -27, 1, bI and -40 or -21, bW),
                            Position = h:Position(0, 4, 0, 17, bW),
                            Color = k.outline
                        }, aw.holder.drawings)
                        local b_ = h:Create("Frame", {Vector2.new(1, 1), bZ}, {
                            Size = h:Size(1, -2, 1, -2, bZ),
                            Position = h:Position(0, 1, 0, 1, bZ),
                            Color = k.inline
                        }, aw.holder.drawings)
                        local c0 = h:Create("Frame", {Vector2.new(1, 1), b_}, {
                            Size = h:Size(1, -2, 1, -2, b_),
                            Position = h:Position(0, 1, 0, 1, b_),
                            Color = Color3.fromHSV(aw.current[1], 1, 1)
                        }, aw.holder.drawings)
                        aw.holder.background = c0;
                        local c1 = h:Create("Image", {Vector2.new(0, 0), c0}, {
                            Size = h:Size(1, 0, 1, 0, c0),
                            Position = h:Position(0, 0, 0, 0, c0)
                        }, aw.holder.drawings)
                        aw.holder.picker = c1;
                        local c2 = h:Create("Image", {Vector2.new(c1.Size.X * aw.current[2] - 3,
                            c1.Size.Y * (1 - aw.current[3]) - 3), c1}, {
                            Size = h:Size(0, 6, 0, 6, c1),
                            Position = h:Position(aw.current[2], -3, 1 - aw.current[3], -3, c1)
                        }, aw.holder.drawings)
                        aw.holder.picker_cursor = c2;
                        local c3 = h:Create("Frame", {Vector2.new(bW.Size.X - 19, 17), bW}, {
                            Size = h:Size(0, 15, 1, bI and -40 or -21, bW),
                            Position = h:Position(1, -19, 0, 17, bW),
                            Color = k.outline
                        }, aw.holder.drawings)
                        local c4 = h:Create("Frame", {Vector2.new(1, 1), c3}, {
                            Size = h:Size(1, -2, 1, -2, c3),
                            Position = h:Position(0, 1, 0, 1, c3),
                            Color = k.inline
                        }, aw.holder.drawings)
                        local c5 = h:Create("Image", {Vector2.new(1, 1), c4}, {
                            Size = h:Size(1, -2, 1, -2, c4),
                            Position = h:Position(0, 1, 0, 1, c4)
                        }, aw.holder.drawings)
                        aw.holder.huepicker = c5;
                        local c6 = h:Create("Frame", {Vector2.new(-3, c5.Size.Y * aw.current[1] - 3), c5}, {
                            Size = h:Size(1, 6, 0, 6, c5),
                            Position = h:Position(0, -3, aw.current[1], -3, c5),
                            Color = k.outline
                        }, aw.holder.drawings)
                        aw.holder.huepicker_cursor[1] = c6;
                        local c7 = h:Create("Frame", {Vector2.new(1, 1), c6}, {
                            Size = h:Size(1, -2, 1, -2, c6),
                            Position = h:Position(0, 1, 0, 1, c6),
                            Color = k.textcolor
                        }, aw.holder.drawings)
                        aw.holder.huepicker_cursor[2] = c7;
                        local c8 = h:Create("Frame", {Vector2.new(1, 1), c7}, {
                            Size = h:Size(1, -2, 1, -2, c7),
                            Position = h:Position(0, 1, 0, 1, c7),
                            Color = Color3.fromHSV(aw.current[1], 1, 1)
                        }, aw.holder.drawings)
                        aw.holder.huepicker_cursor[3] = c8;
                        if bI then
                            local c9 = h:Create("Frame", {Vector2.new(4, bW.Size.X - 19), bW}, {
                                Size = h:Size(1, -27, 0, 15, bW),
                                Position = h:Position(0, 4, 1, -19, bW),
                                Color = k.outline
                            }, aw.holder.drawings)
                            local ca = h:Create("Frame", {Vector2.new(1, 1), c9}, {
                                Size = h:Size(1, -2, 1, -2, c9),
                                Position = h:Position(0, 1, 0, 1, c9),
                                Color = k.inline
                            }, aw.holder.drawings)
                            local cb = h:Create("Frame", {Vector2.new(1, 1), ca}, {
                                Size = h:Size(1, -2, 1, -2, ca),
                                Position = h:Position(0, 1, 0, 1, ca),
                                Color = Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3])
                            }, aw.holder.drawings)
                            aw.holder.transparencybg = cb;
                            local cc = h:Create("Image", {Vector2.new(1, 1), ca}, {
                                Size = h:Size(1, -2, 1, -2, ca),
                                Position = h:Position(0, 1, 0, 1, ca)
                            }, aw.holder.drawings)
                            aw.holder.transparency = cc;
                            local cd = h:Create("Frame", {Vector2.new(cc.Size.X * (1 - aw.current[4]) - 3, -3), cc}, {
                                Size = h:Size(0, 6, 1, 6, cc),
                                Position = h:Position(1 - aw.current[4], -3, 0, -3, cc),
                                Color = k.outline
                            }, aw.holder.drawings)
                            aw.holder.transparency_cursor[1] = cd;
                            local ce = h:Create("Frame", {Vector2.new(1, 1), cd}, {
                                Size = h:Size(1, -2, 1, -2, cd),
                                Position = h:Position(0, 1, 0, 1, cd),
                                Color = k.textcolor
                            }, aw.holder.drawings)
                            aw.holder.transparency_cursor[2] = ce;
                            local cf = h:Create("Frame", {Vector2.new(1, 1), ce}, {
                                Size = h:Size(1, -2, 1, -2, ce),
                                Position = h:Position(0, 1, 0, 1, ce),
                                Color = Color3.fromHSV(0, 0, 1 - aw.current[4])
                            }, aw.holder.drawings)
                            aw.holder.transparency_cursor[3] = cf;
                            h:LoadImage(cc, "transp", "https://i.imgur.com/ncssKbH.png")
                        end
                        h:LoadImage(c1, "valsat", "https://i.imgur.com/wpDRqVH.png")
                        h:LoadImage(c2, "valsat_cursor",
                            "https://raw.githubusercontent.com/mvonwalk/splix-assets/main/Images-cursorcursor.png")
                        h:LoadImage(c5, "hue", "https://i.imgur.com/iEOsHFv.png")
                        ae.currentContent.frame = bV;
                        ae.currentContent.colorpicker = aw
                    else
                        aw.open = not aw.open;
                        for F, G in pairs(aw.holder.drawings) do
                            h:Remove(G)
                        end
                        aw.holder.drawings = {}
                        aw.holder.inline = nil;
                        ae.currentContent.frame = nil;
                        ae.currentContent.colorpicker = nil
                    end
                else
                    if aw.open then
                        aw.open = not aw.open;
                        for F, G in pairs(aw.holder.drawings) do
                            h:Remove(G)
                        end
                        aw.holder.drawings = {}
                        aw.holder.inline = nil;
                        ae.currentContent.frame = nil;
                        ae.currentContent.colorpicker = nil
                    end
                end
            elseif aY.UserInputType == Enum.UserInputType.MouseButton1 and aw.open then
                aw.open = not aw.open;
                for F, G in pairs(aw.holder.drawings) do
                    h:Remove(G)
                end
                aw.holder.drawings = {}
                aw.holder.inline = nil;
                ae.currentContent.frame = nil;
                ae.currentContent.colorpicker = nil
            end
        end;
        g.ended[#g.ended + 1] = function(aY)
            if aY.UserInputType == Enum.UserInputType.MouseButton1 then
                if aw.holding.picker then
                    aw.holding.picker = not aw.holding.picker
                end
                if aw.holding.huepicker then
                    aw.holding.huepicker = not aw.holding.huepicker
                end
                if aw.holding.transparency then
                    aw.holding.transparency = not aw.holding.transparency
                end
            end
        end;
        g.changed[#g.changed + 1] = function()
            if aw.open and aw.holding.picker or aw.holding.huepicker or aw.holding.transparency then
                if ae.isVisible then
                    aw:Refresh()
                else
                    if aw.holding.picker then
                        aw.holding.picker = not aw.holding.picker
                    end
                    if aw.holding.huepicker then
                        aw.holding.huepicker = not aw.holding.huepicker
                    end
                    if aw.holding.transparency then
                        aw.holding.transparency = not aw.holding.transparency
                    end
                end
            end
        end;
        if bv and tostring(bv) ~= "" and tostring(bv) ~= " " and not g.pointers[tostring(bv)] then
            g.pointers[tostring(bv)] = aw
        end
        ba.currentAxis = ba.currentAxis + 15 + 4;
        ba:Update()
        function aw:Colorpicker(aa)
            local aa = aa or {}
            local bH = aa.info or aa.Info or ab;
            local by = aa.def or aa.Def or aa.default or aa.Default or Color3.fromRGB(255, 0, 0)
            local bI = aa.transparency or aa.Transparency or aa.transp or aa.Transp or aa.alpha or aa.Alpha or nil;
            local bv = aa.pointer or aa.Pointer or aa.flag or aa.Flag or nil;
            local bz = aa.callback or aa.callBack or aa.Callback or aa.CallBack or function()
            end;
            aw.secondColorpicker = true;
            local bJ, bK, bL = by:ToHSV()
            local aw = {
                axis = aw.axis,
                current = {bJ, bK, bL, bI or 0},
                holding = {
                    picker = false,
                    huepicker = false,
                    transparency = false
                },
                holder = {
                    inline = nil,
                    picker = nil,
                    picker_cursor = nil,
                    huepicker = nil,
                    huepicker_cursor = {},
                    transparency = nil,
                    transparencybg = nil,
                    transparency_cursor = {},
                    drawings = {}
                }
            }
            bM.Position = h:Position(1, -(60 + 8), 0, aw.axis, ba.section_frame)
            h:UpdateOffset(bM, {Vector2.new(ba.section_frame.Size.X - (60 + 8), aw.axis), ba.section_frame})
            local bM = h:Create("Frame", {Vector2.new(ba.section_frame.Size.X - (30 + 4), aw.axis), ba.section_frame},
                {
                    Size = h:Size(0, 30, 0, 15),
                    Position = h:Position(1, -(30 + 4), 0, aw.axis, ba.section_frame),
                    Color = k.outline,
                    Visible = b3.open
                }, ba.visibleContent)
            local bN = h:Create("Frame", {Vector2.new(1, 1), bM}, {
                Size = h:Size(1, -2, 1, -2, bM),
                Position = h:Position(0, 1, 0, 1, bM),
                Color = k.inline,
                Visible = b3.open
            }, ba.visibleContent)
            local bO;
            if bI then
                bO = h:Create("Image", {Vector2.new(1, 1), bN}, {
                    Size = h:Size(1, -2, 1, -2, bN),
                    Position = h:Position(0, 1, 0, 1, bN),
                    Visible = b3.open
                }, ba.visibleContent)
            end
            local bP = h:Create("Frame", {Vector2.new(1, 1), bN}, {
                Size = h:Size(1, -2, 1, -2, bN),
                Position = h:Position(0, 1, 0, 1, bN),
                Color = by,
                Transparency = bI and 1 - bI or 1,
                Visible = b3.open
            }, ba.visibleContent)
            local bQ = h:Create("Image", {Vector2.new(0, 0), bP}, {
                Size = h:Size(1, 0, 1, 0, bP),
                Position = h:Position(0, 0, 0, 0, bP),
                Transparency = 0.5,
                Visible = b3.open
            }, ba.visibleContent)
            if bI then
                h:LoadImage(bO, "cptransp", "https://i.imgur.com/IIPee2A.png")
            end
            h:LoadImage(bQ, "gradient", "https://i.imgur.com/5hmlrjX.png")
            function aw:Set(bR, bS)
                if typeof(bR) == "table" then
                    aw.current = bR;
                    bP.Color = Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3])
                    bP.Transparency = 1 - aw.current[4]
                    bz(Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3]), aw.current[4])
                elseif typeof(bR) == "color3" then
                    local bT, b2, G = bR:ToHSV()
                    aw.current = {bT, b2, G, bS or 0}
                    bP.Color = Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3])
                    bP.Transparency = 1 - aw.current[4]
                    bz(Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3]), aw.current[4])
                end
            end
            function aw:Refresh()
                local S = h:MouseLocation()
                if aw.open and aw.holder.picker and aw.holding.picker then
                    aw.current[2] = math.clamp(S.X - aw.holder.picker.Position.X, 0, aw.holder.picker.Size.X) /
                                        aw.holder.picker.Size.X;
                    aw.current[3] = 1 - math.clamp(S.Y - aw.holder.picker.Position.Y, 0, aw.holder.picker.Size.Y) /
                                        aw.holder.picker.Size.Y;
                    aw.holder.picker_cursor.Position = h:Position(aw.current[2], -3, 1 - aw.current[3], -3,
                        aw.holder.picker)
                    h:UpdateOffset(aw.holder.picker_cursor,
                        {Vector2.new(aw.holder.picker.Size.X * aw.current[2] - 3,
                            aw.holder.picker.Size.Y * (1 - aw.current[3]) - 3), aw.holder.picker})
                    if aw.holder.transparencybg then
                        aw.holder.transparencybg.Color = Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3])
                    end
                elseif aw.open and aw.holder.huepicker and aw.holding.huepicker then
                    aw.current[1] = math.clamp(S.Y - aw.holder.huepicker.Position.Y, 0, aw.holder.huepicker.Size.Y) /
                                        aw.holder.huepicker.Size.Y;
                    aw.holder.huepicker_cursor[1].Position = h:Position(0, -3, aw.current[1], -3, aw.holder.huepicker)
                    aw.holder.huepicker_cursor[2].Position = h:Position(0, 1, 0, 1, aw.holder.huepicker_cursor[1])
                    aw.holder.huepicker_cursor[3].Position = h:Position(0, 1, 0, 1, aw.holder.huepicker_cursor[2])
                    aw.holder.huepicker_cursor[3].Color = Color3.fromHSV(aw.current[1], 1, 1)
                    h:UpdateOffset(aw.holder.huepicker_cursor[1], {Vector2.new(-3, aw.holder.huepicker.Size.Y *
                        aw.current[1] - 3), aw.holder.huepicker})
                    aw.holder.background.Color = Color3.fromHSV(aw.current[1], 1, 1)
                    if aw.holder.transparency_cursor and aw.holder.transparency_cursor[3] then
                        aw.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - aw.current[4])
                    end
                    if aw.holder.transparencybg then
                        aw.holder.transparencybg.Color = Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3])
                    end
                elseif aw.open and aw.holder.transparency and aw.holding.transparency then
                    aw.current[4] = 1 -
                                        math.clamp(S.X - aw.holder.transparency.Position.X, 0,
                            aw.holder.transparency.Size.X) / aw.holder.transparency.Size.X;
                    aw.holder.transparency_cursor[1].Position =
                        h:Position(1 - aw.current[4], -3, 0, -3, aw.holder.transparency)
                    aw.holder.transparency_cursor[2].Position = h:Position(0, 1, 0, 1, aw.holder.transparency_cursor[1])
                    aw.holder.transparency_cursor[3].Position = h:Position(0, 1, 0, 1, aw.holder.transparency_cursor[2])
                    aw.holder.transparency_cursor[3].Color = Color3.fromHSV(0, 0, 1 - aw.current[4])
                    bP.Transparency = 1 - aw.current[4]
                    h:UpdateTransparency(bP, 1 - aw.current[4])
                    h:UpdateOffset(aw.holder.transparency_cursor[1], {Vector2.new(
                        aw.holder.transparency.Size.X * (1 - aw.current[4]) - 3, -3), aw.holder.transparency})
                    aw.holder.background.Color = Color3.fromHSV(aw.current[1], 1, 1)
                end
                aw:Set(aw.current)
            end
            function aw:Get()
                return Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3])
            end
            g.began[#g.began + 1] = function(aY)
                if aY.UserInputType == Enum.UserInputType.MouseButton1 and ae.isVisible and bM.Visible then
                    if aw.open and aw.holder.inline and
                        h:MouseOverDrawing({aw.holder.inline.Position.X, aw.holder.inline.Position.Y,
                                            aw.holder.inline.Position.X + aw.holder.inline.Size.X,
                                            aw.holder.inline.Position.Y + aw.holder.inline.Size.Y}) then
                        if aw.holder.picker and
                            h:MouseOverDrawing({aw.holder.picker.Position.X - 2, aw.holder.picker.Position.Y - 2,
                                                aw.holder.picker.Position.X - 2 + aw.holder.picker.Size.X + 4,
                                                aw.holder.picker.Position.Y - 2 + aw.holder.picker.Size.Y + 4}) then
                            aw.holding.picker = true;
                            aw:Refresh()
                        elseif aw.holder.huepicker and
                            h:MouseOverDrawing({aw.holder.huepicker.Position.X - 2, aw.holder.huepicker.Position.Y - 2,
                                                aw.holder.huepicker.Position.X - 2 + aw.holder.huepicker.Size.X + 4,
                                                aw.holder.huepicker.Position.Y - 2 + aw.holder.huepicker.Size.Y + 4}) then
                            aw.holding.huepicker = true;
                            aw:Refresh()
                        elseif aw.holder.transparency and
                            h:MouseOverDrawing(
                                {aw.holder.transparency.Position.X - 2, aw.holder.transparency.Position.Y - 2,
                                 aw.holder.transparency.Position.X - 2 + aw.holder.transparency.Size.X + 4,
                                 aw.holder.transparency.Position.Y - 2 + aw.holder.transparency.Size.Y + 4}) then
                            aw.holding.transparency = true;
                            aw:Refresh()
                        end
                    elseif h:MouseOverDrawing({ba.section_frame.Position.X + ba.section_frame.Size.X - (30 + 4 + 2),
                                               ba.section_frame.Position.Y + aw.axis,
                                               ba.section_frame.Position.X + ba.section_frame.Size.X,
                                               ba.section_frame.Position.Y + aw.axis + 15}) and not ae:IsOverContent() then
                        if not aw.open then
                            ae:CloseContent()
                            aw.open = not aw.open;
                            local bU = h:Create("Frame", {Vector2.new(4, aw.axis + 19), ba.section_frame}, {
                                Size = h:Size(1, -8, 0, bI and 219 or 200, ba.section_frame),
                                Position = h:Position(0, 4, 0, aw.axis + 19, ba.section_frame),
                                Color = k.outline
                            }, aw.holder.drawings)
                            aw.holder.inline = bU;
                            local bV = h:Create("Frame", {Vector2.new(1, 1), bU}, {
                                Size = h:Size(1, -2, 1, -2, bU),
                                Position = h:Position(0, 1, 0, 1, bU),
                                Color = k.inline
                            }, aw.holder.drawings)
                            local bW = h:Create("Frame", {Vector2.new(1, 1), bV}, {
                                Size = h:Size(1, -2, 1, -2, bV),
                                Position = h:Position(0, 1, 0, 1, bV),
                                Color = k.dark_contrast
                            }, aw.holder.drawings)
                            local bX = h:Create("Frame", {Vector2.new(0, 0), bW}, {
                                Size = h:Size(1, 0, 0, 2, bW),
                                Position = h:Position(0, 0, 0, 0, bW),
                                Color = k.accent
                            }, aw.holder.drawings)
                            local bY = h:Create("TextLabel", {Vector2.new(4, 2), bW}, {
                                Text = bH,
                                Size = k.textsize,
                                Font = k.font,
                                Color = k.textcolor,
                                OutlineColor = k.textborder,
                                Position = h:Position(0, 4, 0, 2, bW)
                            }, aw.holder.drawings)
                            local bZ = h:Create("Frame", {Vector2.new(4, 17), bW}, {
                                Size = h:Size(1, -27, 1, bI and -40 or -21, bW),
                                Position = h:Position(0, 4, 0, 17, bW),
                                Color = k.outline
                            }, aw.holder.drawings)
                            local b_ = h:Create("Frame", {Vector2.new(1, 1), bZ}, {
                                Size = h:Size(1, -2, 1, -2, bZ),
                                Position = h:Position(0, 1, 0, 1, bZ),
                                Color = k.inline
                            }, aw.holder.drawings)
                            local c0 = h:Create("Frame", {Vector2.new(1, 1), b_}, {
                                Size = h:Size(1, -2, 1, -2, b_),
                                Position = h:Position(0, 1, 0, 1, b_),
                                Color = Color3.fromHSV(aw.current[1], 1, 1)
                            }, aw.holder.drawings)
                            aw.holder.background = c0;
                            local c1 = h:Create("Image", {Vector2.new(0, 0), c0}, {
                                Size = h:Size(1, 0, 1, 0, c0),
                                Position = h:Position(0, 0, 0, 0, c0)
                            }, aw.holder.drawings)
                            aw.holder.picker = c1;
                            local c2 = h:Create("Image", {Vector2.new(c1.Size.X * aw.current[2] - 3,
                                c1.Size.Y * (1 - aw.current[3]) - 3), c1}, {
                                Size = h:Size(0, 6, 0, 6, c1),
                                Position = h:Position(aw.current[2], -3, 1 - aw.current[3], -3, c1)
                            }, aw.holder.drawings)
                            aw.holder.picker_cursor = c2;
                            local c3 = h:Create("Frame", {Vector2.new(bW.Size.X - 19, 17), bW}, {
                                Size = h:Size(0, 15, 1, bI and -40 or -21, bW),
                                Position = h:Position(1, -19, 0, 17, bW),
                                Color = k.outline
                            }, aw.holder.drawings)
                            local c4 = h:Create("Frame", {Vector2.new(1, 1), c3}, {
                                Size = h:Size(1, -2, 1, -2, c3),
                                Position = h:Position(0, 1, 0, 1, c3),
                                Color = k.inline
                            }, aw.holder.drawings)
                            local c5 = h:Create("Image", {Vector2.new(1, 1), c4}, {
                                Size = h:Size(1, -2, 1, -2, c4),
                                Position = h:Position(0, 1, 0, 1, c4)
                            }, aw.holder.drawings)
                            aw.holder.huepicker = c5;
                            local c6 = h:Create("Frame", {Vector2.new(-3, c5.Size.Y * aw.current[1] - 3), c5}, {
                                Size = h:Size(1, 6, 0, 6, c5),
                                Position = h:Position(0, -3, aw.current[1], -3, c5),
                                Color = k.outline
                            }, aw.holder.drawings)
                            aw.holder.huepicker_cursor[1] = c6;
                            local c7 = h:Create("Frame", {Vector2.new(1, 1), c6}, {
                                Size = h:Size(1, -2, 1, -2, c6),
                                Position = h:Position(0, 1, 0, 1, c6),
                                Color = k.textcolor
                            }, aw.holder.drawings)
                            aw.holder.huepicker_cursor[2] = c7;
                            local c8 = h:Create("Frame", {Vector2.new(1, 1), c7}, {
                                Size = h:Size(1, -2, 1, -2, c7),
                                Position = h:Position(0, 1, 0, 1, c7),
                                Color = Color3.fromHSV(aw.current[1], 1, 1)
                            }, aw.holder.drawings)
                            aw.holder.huepicker_cursor[3] = c8;
                            if bI then
                                local c9 = h:Create("Frame", {Vector2.new(4, bW.Size.X - 19), bW}, {
                                    Size = h:Size(1, -27, 0, 15, bW),
                                    Position = h:Position(0, 4, 1, -19, bW),
                                    Color = k.outline
                                }, aw.holder.drawings)
                                local ca = h:Create("Frame", {Vector2.new(1, 1), c9}, {
                                    Size = h:Size(1, -2, 1, -2, c9),
                                    Position = h:Position(0, 1, 0, 1, c9),
                                    Color = k.inline
                                }, aw.holder.drawings)
                                local cb = h:Create("Frame", {Vector2.new(1, 1), ca}, {
                                    Size = h:Size(1, -2, 1, -2, ca),
                                    Position = h:Position(0, 1, 0, 1, ca),
                                    Color = Color3.fromHSV(aw.current[1], aw.current[2], aw.current[3])
                                }, aw.holder.drawings)
                                aw.holder.transparencybg = cb;
                                local cc = h:Create("Image", {Vector2.new(1, 1), ca}, {
                                    Size = h:Size(1, -2, 1, -2, ca),
                                    Position = h:Position(0, 1, 0, 1, ca)
                                }, aw.holder.drawings)
                                aw.holder.transparency = cc;
                                local cd = h:Create("Frame", {Vector2.new(cc.Size.X * (1 - aw.current[4]) - 3, -3), cc},
                                    {
                                        Size = h:Size(0, 6, 1, 6, cc),
                                        Position = h:Position(1 - aw.current[4], -3, 0, -3, cc),
                                        Color = k.outline
                                    }, aw.holder.drawings)
                                aw.holder.transparency_cursor[1] = cd;
                                local ce = h:Create("Frame", {Vector2.new(1, 1), cd}, {
                                    Size = h:Size(1, -2, 1, -2, cd),
                                    Position = h:Position(0, 1, 0, 1, cd),
                                    Color = k.textcolor
                                }, aw.holder.drawings)
                                aw.holder.transparency_cursor[2] = ce;
                                local cf = h:Create("Frame", {Vector2.new(1, 1), ce}, {
                                    Size = h:Size(1, -2, 1, -2, ce),
                                    Position = h:Position(0, 1, 0, 1, ce),
                                    Color = Color3.fromHSV(0, 0, 1 - aw.current[4])
                                }, aw.holder.drawings)
                                aw.holder.transparency_cursor[3] = cf;
                                h:LoadImage(cc, "transp", "https://i.imgur.com/ncssKbH.png")
                            end
                            h:LoadImage(c1, "valsat", "https://i.imgur.com/wpDRqVH.png")
                            h:LoadImage(c5, "hue", "https://i.imgur.com/iEOsHFv.png")
                            ae.currentContent.frame = bV;
                            ae.currentContent.colorpicker = aw
                        else
                            aw.open = not aw.open;
                            for F, G in pairs(aw.holder.drawings) do
                                h:Remove(G)
                            end
                            aw.holder.drawings = {}
                            aw.holder.inline = nil;
                            ae.currentContent.frame = nil;
                            ae.currentContent.colorpicker = nil
                        end
                    else
                        if aw.open then
                            aw.open = not aw.open;
                            for F, G in pairs(aw.holder.drawings) do
                                h:Remove(G)
                            end
                            aw.holder.drawings = {}
                            aw.holder.inline = nil;
                            ae.currentContent.frame = nil;
                            ae.currentContent.colorpicker = nil
                        end
                    end
                elseif aY.UserInputType == Enum.UserInputType.MouseButton1 and aw.open then
                    aw.open = not aw.open;
                    for F, G in pairs(aw.holder.drawings) do
                        h:Remove(G)
                    end
                    aw.holder.drawings = {}
                    aw.holder.inline = nil;
                    ae.currentContent.frame = nil;
                    ae.currentContent.colorpicker = nil
                end
            end;
            g.ended[#g.ended + 1] = function(aY)
                if aY.UserInputType == Enum.UserInputType.MouseButton1 then
                    if aw.holding.picker then
                        aw.holding.picker = not aw.holding.picker
                    end
                    if aw.holding.huepicker then
                        aw.holding.huepicker = not aw.holding.huepicker
                    end
                    if aw.holding.transparency then
                        aw.holding.transparency = not aw.holding.transparency
                    end
                end
            end;
            g.changed[#g.changed + 1] = function()
                if aw.open and aw.holding.picker or aw.holding.huepicker or aw.holding.transparency then
                    if ae.isVisible then
                        aw:Refresh()
                    else
                        if aw.holding.picker then
                            aw.holding.picker = not aw.holding.picker
                        end
                        if aw.holding.huepicker then
                            aw.holding.huepicker = not aw.holding.huepicker
                        end
                        if aw.holding.transparency then
                            aw.holding.transparency = not aw.holding.transparency
                        end
                    end
                end
            end;
            if bv and tostring(bv) ~= "" and tostring(bv) ~= " " and not g.pointers[tostring(bv)] then
                g.pointers[tostring(bv)] = keybind
            end
            return aw
        end
        return aw
    end
    function j:ConfigBox(aa)
        local aa = aa or {}
        local ae = self.window;
        local b3 = self.page;
        local ba = self;
        local db = {
            axis = ba.currentAxis,
            current = 1,
            buttons = {}
        }
        local dc = h:Create("Frame", {Vector2.new(4, db.axis), ba.section_frame}, {
            Size = h:Size(1, -8, 0, 148, ba.section_frame),
            Position = h:Position(0, 4, 0, db.axis, ba.section_frame),
            Color = k.outline,
            Visible = b3.open
        }, ba.visibleContent)
        local dd = h:Create("Frame", {Vector2.new(1, 1), dc}, {
            Size = h:Size(1, -2, 1, -2, dc),
            Position = h:Position(0, 1, 0, 1, dc),
            Color = k.inline,
            Visible = b3.open
        }, ba.visibleContent)
        local de = h:Create("Frame", {Vector2.new(1, 1), dd}, {
            Size = h:Size(1, -2, 1, -2, dd),
            Position = h:Position(0, 1, 0, 1, dd),
            Color = k.light_contrast,
            Visible = b3.open
        }, ba.visibleContent)
        local df = h:Create("Image", {Vector2.new(0, 0), de}, {
            Size = h:Size(1, 0, 1, 0, de),
            Position = h:Position(0, 0, 0, 0, de),
            Transparency = 0.5,
            Visible = b3.open
        }, ba.visibleContent)
        for F = 1, 8 do
            local dg = h:Create("TextLabel", {Vector2.new(de.Size.X / 2, 2 + 18 * (F - 1)), de}, {
                Text = "Config-Slot: " .. tostring(F),
                Size = k.textsize,
                Font = k.font,
                Color = F == 1 and k.accent or k.textcolor,
                OutlineColor = k.textborder,
                Center = true,
                Position = h:Position(0.5, 0, 0, 2 + 18 * (F - 1), de),
                Visible = b3.open
            }, ba.visibleContent)
            db.buttons[F] = dg
        end
        h:LoadImage(df, "gradient", "https://i.imgur.com/5hmlrjX.png")
        function db:Refresh()
            for F, G in pairs(db.buttons) do
                G.Color = F == db.current and k.accent or k.textcolor
            end
        end
        function db:Get()
            return db.current
        end
        function db:Set(dh)
            db.current = dh;
            db:Refresh()
        end
        g.began[#g.began + 1] = function(aY)
            if aY.UserInputType == Enum.UserInputType.MouseButton1 and dc.Visible and ae.isVisible and
                h:MouseOverDrawing({ba.section_frame.Position.X, ba.section_frame.Position.Y + db.axis,
                                    ba.section_frame.Position.X + ba.section_frame.Size.X,
                                    ba.section_frame.Position.Y + db.axis + 148}) and not ae:IsOverContent() then
                for F = 1, 8 do
                    if h:MouseOverDrawing({ba.section_frame.Position.X,
                                           ba.section_frame.Position.Y + db.axis + 2 + 18 * (F - 1),
                                           ba.section_frame.Position.X + ba.section_frame.Size.X,
                                           ba.section_frame.Position.Y + db.axis + 2 + 18 * (F - 1) + 18}) then
                        db.current = F;
                        db:Refresh()
                    end
                end
            end
        end;
        ae.pointers["configbox"] = db;
        ba.currentAxis = ba.currentAxis + 148 + 4;
        ba:Update()
        return db
    end
end
return g, h, g.pointers, k
