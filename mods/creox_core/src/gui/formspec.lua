local Formspec = class.extend("Formspec")
creox.gui.Formspec = Formspec

local function argument_parser(argument)
    local string_argument = ""

    if type(argument) == "table" then
        for index, value in pairs(argument) do
            string_argument = 
                string_argument ..
                tostring(value) ..
                (argument[index+1] ~= nil and "," or "")
        end
    else
        string_argument = tostring(argument)
    end

    return string_argument
end

local function element_parser(element)
    local element_type = element[1]
    local string_arguments = ""

    for index, argument in pairs(element[2]) do
        string_arguments = 
            string_arguments ..
            argument_parser(argument)
        
        if (element[2][index+1] ~= nil) then
            if type(argument) == "table" then
                string_arguments = string_arguments .. ";"
            else
                string_arguments = string_arguments .. ","
            end
        end
    end

    return ("%s[%s]"):format(element_type, string_arguments)
end

local function elements_parser(elements)
    local formspec = ""
    for index, element in pairs(elements) do
        formspec = formspec .. element_parser(element) .. "\n"
    end
    return formspec
end

function Formspec:init()
    self._formspec = {}
end

function Formspec:get()
    local gui = elements_parser(self._formspec)

    --minetest.log(gui)
    return gui
end

function Formspec:element(name, ...)
    table.insert(self._formspec, {name, {...}})
end

--> Element Manipulators

function Formspec:set_canvas_size(width, height, fixed)
    self:element("size", {width, height}, fixed)
end

function Formspec:use_real_coordinates()
    self:element("real_coordinates", true)
end

function Formspec:set_version(version)
    self:element("formspec_version", version)
end

function Formspec:position(x, y)
    self:element("position", {x, y})
end

function Formspec:anchor(x, y)
    self:element("anchor", {x, y})
end

function Formspec:padding(x, y)
    self:element("padding", {x, y})
end

function Formspec:no_prepend()
    self:element("no_prepend")
end

function Formspec:container_end()
    self:element("container_end")
end

function Formspec:scroll_container_end()
    self:element("scroll_container_end")
end

function Formspec:background_color(color, fullscreen, foreground_color)
    self:element("bgcolor", {color}, {fullscreen}, {foreground_color})
end

function Formspec:background_texture(x, y, width, height, texture, auto_clip)
    self:element("background", {x, y}, {width, height}, {texture}, {auto_clip})
end

function Formspec:background9_texture(x, y, width, height, texture, auto_clip, middle)
    self:element("background9", {x, y}, {width, height}, {texture}, {auto_clip}, {middle})
end

function Formspec:field_close_on_enter(name, close_on_enter)
    self:element("field_close_on_enter", {name}, {close_on_enter})
end

function Formspec:scrollbar_options(options)
    self:element("scrollbaroptions", options)
end

function Formspec:table_options(options)
    self:element("tableoptions", options)
end

function Formspec:style_type(selectors, props)
    self:element("style_type", {selectors}, {props})
end

function Formspec:set_focus(name, force)
    self:element("set_focus", {name}, {force})
end

--> Elements

function Formspec:container(x, y)
    self:element("container", {x, y})
end

function Formspec:scroll_container(x, y, width, height, scrollbar_name, orienation, scroll_factor)
    self:element("scroll_container", {x, y}, {width, height}, {scrollbar_name}, {orienation}, {scroll_factor})
end

function Formspec:list(inventory_location, list_name, x, y, width, height, start_index)
    self:element("list", {inventory_location}, {list_name}, {x, y}, {width, height}, {start_index})
end

function Formspec:list_string(inventory_location, list_name)
    self:element("listring", inventory_location, list_name)
end

function Formspec:list_colors(slot_background_normal, slot_background_hover, slot_border_color, tooltip_background_color, tooltip_fontcolor)
    self:element("listcolors", {slot_background_normal}, {slot_background_hover}, {slot_border_color}, {tooltip_background_color}, {tooltip_fontcolor})
end

function Formspec:tool_tip(x, y, width, height, text, background_color, font_color)
    self:element("tooltip", {x, y}, {width, height}, {text}, {background_color}, {font_color})
end

function Formspec:tool_tip_element(gui_element_name, text, background_color, font_color)
    self:element("tooltip", {gui_element_name}, {text}, {background_color}, {font_color})
end

function Formspec:image(x, y, width, height, texture)
    self:element("image", {x, y}, {width, height}, {texture})
end

function Formspec:animated_image(x, y, width, height, name, texture, frame_count, frame_duration, frame_start)
    self:element("animated_image", {x, y}, {width, height}, {name}, {texture}, {frame_count}, {frame_duration}, {frame_start})
end

function Formspec:model(x, y, width, height, name, mesh, textures, rotation, continuous, mouse_control, frame_loop_range, animation_speed)
    self:element("model", {x, y}, {width, height}, {name}, {mesh}, {textures}, {rotation}, {continuous}, {mouse_control}, {frame_loop_range}, {animation_speed})
end

function Formspec:item_image(x, y, width, height, item_name)
    self:element("item_image", {x, y}, {width, height}, item_name)
end

function Formspec:password_field(x, y, width, height, name, label)
    self:element("pwdfield", {x, y}, {width, height}, {name}, {label})
end

function Formspec:field(name, label, default)
    self:element("field", {name}, {label}, {default})
end

function Formspec:text_area(x, y, width ,height, name, label, default)
    self:element("textarea", {x, y}, {width ,height}, {name}, {label}, {default})
end

function Formspec:label(x, y, label)
    self:element("label", {x, y}, {label})
end

function Formspec:hypertext(x, y, width, height, name, text)
    self:element("hypertext", {x, y}, {width, height}, {name}, {text})
end

function Formspec:vertical_label(x, y, label)
    self:element("hypertext", {x, y}, {label})
end

function Formspec:button(x, y, width, height, name, label)
    self:element("button", {x, y}, {width, height}, {name}, {label})
end

function Formspec:image_button(x, y, width, height, texture, name, label, no_clip, drawborder, pressed_texture)
    self:element("image_button", {x, y}, {width, height}, {texture}, {name}, {label}, {no_clip}, {drawborder}, {pressed_texture})
end

function Formspec:item_image_button(x, y, width, height, item_name, name, label)
    self:element("item_image_button", {x, y}, {width, height}, {item_name}, {name}, {label})
end

function Formspec:text_list(x, y, width, height, name, elements, selected_id, transparent)
    self:element("textlist", {x, y}, {width, height}, {name}, {elements}, {selected_id}, {transparent})
end

function Formspec:tab_header(x, y, width, height, name, captions, current_tab, transparent, draw_border)
    self:element("tabheader", {x, y}, {width, height}, {name}, {captions}, {current_tab}, {transparent}, {draw_border})
end

function Formspec:box(x, y, width, height, color)
    self:element("box", {x, y}, {width, height}, {color})
end

function Formspec:dropdown(x, y, width, height, name, items, selected_id, index_event)
    self:element("dropdown", {x, y}, {width, height}, {name}, {items}, {selected_id}, {index_event})
end

function Formspec:checkbox(x, y, width, height, orientation, name, value)
    self:element("checkbox", {x, y}, {width, height}, {orientation}, {name}, {value})
end

function Formspec:table(x, y, width, height, name, cells, selected_index)
    self:element("table", {x, y}, {width, height}, {name}, {cells}, {selected_index})
end

function Formspec:table_columns(type_options)
    self:element("tablecolumns", {type_options})
end

function Formspec:custom(element_name, ...)
    self:element(element_name, ...)
end