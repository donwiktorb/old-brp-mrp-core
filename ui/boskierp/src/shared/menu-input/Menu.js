import debounce from "lodash";
import React from "react";
import sendMessage from "../../Api";
import Progbar from "./components/Progbar";

export default class Menu extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            menus: [] || [
                {
                    //hidden: true,
                    settings: { saveButtons: true },
                    name: "brp",
                    title: "Menu Admin",
                    align: "flex justify-end items-end",
                    style: {
                        box: "h-[90%] w-1/4 max-h-full max-w-full top-1/2 -translate-y-1/2 right-5",
                        imgBox: "flex justify-center items-center my-4",
                        img: "w-1/2",
                        elements: "flex flex-col gap-2",
                    },

                    elements: [
                        {
                            type: "img",
                            img: "https://docs.fivem.net/vehicles/akula.webp",
                        },
                        {
                            type: "text",
                            label: "Hello",
                        },
                        { type: "search", label: "Wpisz auto" },
                        {
                            type: "textarea",
                            label: "Wpisz",
                        },
                        {
                            type: "range",
                            label: "Zaznacz ilosc",
                            min: 10,
                            max: 40,
                            step: 1,
                        },
                        { type: "number", label: "Wpisz" },
                        { type: "range-number" },
                        { type: "select", label: "Opcje", options: [{ label: "Hello" }] },
                        {
                            type: "date",
                            label: "Wpisz",
                        },
                        { type: "radio", label: "Wpisz", name: "dddd" },
                        { type: "radio", label: "Wpisz", name: "dddd" },
                        {
                            title: "Dodatki",
                            type: "section",

                            style: {
                                box: "",
                                elements: "flex justify-around gap-4 flex-wrap",
                                title: "sticky top-0",
                                imgBox: "relative flex gap-4 ",
                                img: "group-hover:scale-110 transition-all",
                                button: "w-56 h-fit group",
                                badgeBox: "flex absolute justify-between",
                            },

                            elements: [
                                {
                                    label: "Neony lewo",
                                    value: "neon-left",
                                    type: "checkbox",
                                },
                                {
                                    label: "Neony prawo",
                                    value: "neon-right",
                                    type: "checkbox",
                                },
                                {
                                    label: "Neony przód",
                                    value: "neon-htmlForward",
                                    type: "checkbox",
                                },
                                {
                                    label: "Neony tył",
                                    value: "neon-back",
                                    type: "checkbox",
                                },
                                {
                                    label: "Neony all",
                                    value: "neon-all",
                                    type: "checkbox",
                                },
                                {
                                    label: "Xenony",
                                    value: "xenon",
                                    type: "checkbox",
                                },
                            ],
                        },
                        {
                            title: "Kolory",
                            type: "section",

                            style: {
                                box: "",
                                elements: "flex gap-4 flex-wrap justify-around",
                                title: "sticky top-0",
                            },

                            elements: [
                                {
                                    label: "Kolor główny",
                                    value: "color-main",
                                    type: "color",
                                },
                                {
                                    label: "Kolor dodatkowy",
                                    value: "color-2",
                                    type: "color",
                                },
                                {
                                    label: "Kolor neony",
                                    value: "neon-color",
                                    type: "color",
                                },
                                {
                                    label: "Xenony Kolor",
                                    value: "xenon-color",
                                    type: "color",
                                },
                            ],
                        },
                        //{
                        //  type: "section",
                        //  style: {
                        //    elements: "flex justify-between m-3",
                        //    box: "sticky bottom-0 w-full",
                        //  },
                        //  elements: [
                        //    {
                        //      label: "Powrót",
                        //      //style: 'text-blue-400',
                        //    },
                        //    {
                        //      label: "Zakup",
                        //    },
                        //  ],
                        //},
                        //{
                        //type: "section",
                        //  title: "Arenki",
                        //  style: {
                        //    elements: 'grid grid-flow-col auto-cols-fr gap-4',
                        //  },
                        //  elements: [
                        //    {
                        //      label: "Zarządzanie graczami",
                        //      img: 'https://c4.wallpaperflare.com/wallpaper/794/488/958/gta-gta-gta-5-gta-5-wallpaper-preview.jpg'
                        //    },

                        //    {
                        //      label: "Zarządzanie graczami",
                        //      img: 'https://c4.wallpaperflare.com/wallpaper/794/488/958/gta-gta-gta-5-gta-5-wallpaper-preview.jpg'
                        //    },
                        //    {
                        //      label: "Zarządzanie graczami",
                        //      img: 'https://c4.wallpaperflare.com/wallpaper/794/488/958/gta-gta-gta-5-gta-5-wallpaper-preview.jpg'
                        //    },
                        //    {
                        //      label: "Zarządzanie graczami",
                        //      img: 'https://c4.wallpaperflare.com/wallpaper/794/488/958/gta-gta-gta-5-gta-5-wallpaper-preview.jpg'
                        //    },
                        //  ],
                        //},
                        //{
                        //  selected: true,
                        //  label: "Zarządzanie graczami",
                        //},
                        //{
                        //  label: "Zarządzanie serwerem"
                        //},

                        //{
                        //  label: "Opcje"
                        //},
                        //{
                        //  type: "section",
                        //  title: "Zaakcpetować?",
                        //  style: {
                        //    elements: 'flex justify-between m-3',
                        //    box: 'sticky bottom-0'
                        //  },
                        //  elements: [
                        //    {
                        //      label: "nnnnn",
                        //    }
                        //  ],
                        //},
                        //{
                        //  label: "Wpisz imię",
                        //  type: 'text',
                        //},
                        //{
                        //  label: "Wpisz Nazwisko",
                        //  type: 'text',
                        //}
                    ],
                },
                {
                    name: "brp4444",
                    title: "Menu Admin",
                    align: "justify-start items-end",
                    style: {
                        box: "w-3/5 h-3/5 max-h-full max-w-full top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 ",
                        elements: "flex flex-col gap-4 overflow-auto w-full h-full",
                        imgBox: "relative flex gap-4 ",
                        img: "group-hover:scale-110 transition-all",
                        button: "w-4/5 h-fit group",
                    },
                    hidden: !true,
                    search: "Wpisz jakie auto",
                    filters: [
                        { type: "search", label: "Wpisz auto" },
                        {
                            type: "checkbox",
                            label: "onlyNew",
                        },
                        {
                            type: "checkbox",
                            label: "onlyNew",
                        },
                        {
                            type: "checkbox",
                            label: "onlyNew",
                        },
                        {
                            type: "range-number",
                            value: true,
                            label: "Wpisz cene",

                            fromLabel: "Od",
                            toLabel: "Do",
                        },
                        {
                            type: "select",
                            label: "Kategoria",
                            value: 0,
                            options: [
                                {
                                    label: "Domyślne",
                                },
                            ],
                        },
                    ],
                    elements: [
                        {
                            title: "Limitki",
                            type: "section",

                            subLabels: [
                                { style: "w-full", label: "444.4444444$" },
                                { label: "343KM" },
                                { label: "3.4s" },
                                { label: "343N" },
                            ],
                            style: {
                                box: "",
                                elements: "flex justify-around gap-4 flex-wrap",
                                title: "sticky top-0",
                                imgBox: "relative flex gap-4 ",
                                img: "group-hover:scale-110 transition-all",
                                button: "w-56 h-fit group",
                                badgeBox: "flex absolute justify-between",
                            },
                            badges: [
                                { label: "AUTO" },
                                { label: "AUTO", style: "justify-self-center" },
                            ],
                            elements: [
                                {
                                    label: "nnnnn",
                                    img: "https://docs.fivem.net/vehicles/akula.webp",
                                },
                                ...Array(34).fill({
                                    label: "nnnnn",
                                    label: "nnnnn",
                                    subLabel: "444,4444444444$",
                                    img: "https://docs.fivem.net/vehicles/akula.webp",
                                }),
                            ],
                        },
                        {
                            title: "Limitki",
                            type: "section",

                            subLabels: [
                                { style: "w-full", label: "444.4444444$" },
                                { label: "343KM" },
                                { label: "3.4s" },
                                { label: "343N" },
                            ],
                            style: {
                                box: "",
                                elements: "flex justify-around gap-4 flex-wrap",
                                title: "sticky top-0",
                                imgBox: "relative flex gap-4 ",
                                img: "group-hover:scale-110 transition-all",
                                button: "w-56 h-fit group",
                                badgeBox: "flex absolute justify-between",
                            },
                            badges: [
                                { label: "AUTO" },
                                { label: "AUTO", style: "justify-self-center" },
                            ],
                            elements: [
                                {
                                    label: "nnnnn",
                                    img: "https://docs.fivem.net/vehicles/akula.webp",
                                },
                                ...Array(34).fill({
                                    label: "nnnnn",
                                    label: "nnnnn",
                                    subLabel: "444,4444444444$",
                                    img: "https://docs.fivem.net/vehicles/akula.webp",
                                }),
                            ],
                        },
                        {
                            title: "Samochody",
                            type: "section",
                            subLabels: [
                                { label: "444.44$" },
                                { label: "343KM" },
                                { label: "3.4s" },
                                { label: "343N" },
                            ],
                            style: {
                                box: "",
                                elements: "grid grid-cols-4 gap-4 justify-items-center p-3 ",
                                title: "sticky top-0",
                                imgBox: "relative flex gap-4 ",
                                img: "group-hover:scale-110 transition-all",
                                button: "w-4/5 h-fit group",
                            },
                            elements: [
                                {
                                    label: "nnnnn",
                                    img: "https://docs.fivem.net/vehicles/akula.webp",
                                },
                                ...Array(34).fill({
                                    label: "nnnnn",
                                    img: "https://docs.fivem.net/vehicles/akula.webp",
                                }),
                            ],
                        },
                    ],
                },

                {
                    title: "Limitki",
                    name: "pages",
                    align: "justify-center items-center",
                    style: {
                        box: "h-[90%] w-1/4 max-h-full max-w-full top-1/2 -translate-y-1/2 right-5",
                    },
                    pages: [
                        [
                            {
                                type: "select",
                                name: "engine",
                                label: "Silnik",
                                options: [
                                    {
                                        label: "Level",
                                        value: "level",
                                    },
                                ],
                                value: 0,
                            },
                            ...Array(34).fill({
                                type: "select",
                                name: "engine",
                                label: "Silnik4",
                                options: [
                                    {
                                        label: "Level",
                                        value: "Level",
                                    },
                                ],
                            }),
                        ],

                        [
                            {
                                type: "select",
                                name: "engine",
                                label: "Silnik",
                                options: [
                                    {
                                        label: "Level",
                                        value: "level",
                                    },
                                ],
                                value: 0,
                            },
                            ...Array(34).fill({
                                type: "select",
                                name: "engine",
                                label: "Silnik4444",
                                options: [
                                    {
                                        label: "Level",
                                        value: "Level",
                                    },
                                ],
                            }),
                        ],

                        [
                            {
                                type: "select",
                                name: "engine",
                                label: "Silnik777",
                                options: [
                                    {
                                        label: "Level",
                                        value: "level",
                                    },
                                ],
                                value: 0,
                            },
                            ...Array(34).fill({
                                type: "select",
                                name: "engine",
                                label: "Silnik",
                                options: [
                                    {
                                        label: "Level",
                                        value: "Level",
                                    },
                                ],
                            }),
                        ],

                        [
                            {
                                type: "select",
                                name: "engine",
                                label: "Silnik",
                                options: [
                                    {
                                        label: "Level",
                                        value: "level",
                                    },
                                ],
                                value: 0,
                            },
                            ...Array(34).fill({
                                type: "select",
                                name: "engine",
                                label: "Silnik",
                                options: [
                                    {
                                        label: "Level",
                                        value: "Level",
                                    },
                                ],
                            }),
                        ],
                    ],
                    currentPage: 0,
                },
                {
                    name: "4444brp",
                    title: "Menu Admin",
                    align: "justify-start items-end",
                    style: {},
                    hidden: !true,
                    search: "Wpisz jakie auto",
                    elements: [
                        {
                            label: "Menu",
                            selected: true,
                            type: "slider",
                            min: 0,
                            value: 4,
                            max: 4,
                        },
                        {
                            label: "Menu",
                            type: "slider",
                            value: 0,
                            options: [
                                { label: "dddd" },
                                { label: "ddddd4444" },
                                { label: "4444" },
                            ],
                        },
                        {
                            label: "Menu",
                        },
                    ],
                },

                {
                    name: "brp4444",
                    title: "Menu Admin",
                    align: "justify-start items-end",
                    style: {
                        box: "w-3/5 h-3/5 max-h-full max-w-full top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 ",
                        elements: "flex flex-col gap-4 overflow-auto w-full h-full",
                        imgBox: "relative flex gap-4 flex-col flex-wrap",
                        img: "group-hover:scale-110 transition-all",
                        button: "w-4/5 h-fit group",
                    },
                    hidden: !true,
                    search: "Wpisz jakie auto",
                    filters: [
                        { type: "search", label: "Wpisz auto" },
                        {
                            type: "checkbox",
                            label: "onlyNew",
                            require: "hi",
                        },
                        {
                            type: "checkbox",
                            label: "onlyNew",
                        },
                        {
                            type: "checkbox",
                            label: "onlyNew",
                        },
                        {
                            type: "range-number",
                            value: true,
                            label: "Wpisz cene",

                            fromLabel: "Od",
                            toLabel: "Do",
                        },
                        {
                            type: "select",
                            label: "Kategoria",
                            value: 0,
                            options: [
                                {
                                    label: "Domyślne",
                                },

                                {
                                    label: "Domyślne",
                                },
                            ],
                        },
                    ],
                    elements: [
                        {
                            type: "progbar",
                            label: "Kategoria",
                            time: 30,
                        },
                        {
                            type: "select",
                            label: "Kategoria",
                            value: 0,
                            options: [
                                {
                                    label: "Domyślne",
                                },

                                {
                                    label: "4444",
                                },
                            ],
                        },
                        {
                            type: "table",
                            rows: [{ label: "Id" }, { label: "dddd" }, { label: "dddd" }],
                            elements: [
                                {
                                    rows: [
                                        {
                                            type: "number",
                                            value: 44,
                                        },
                                        {
                                            type: "text",
                                            label: "Zbanowayn za donwiktorb",
                                        },
                                        {
                                            type: "section",
                                            label: "Zbanuj",

                                            style: { box: "" },
                                            elements: [
                                                { label: "Button", type: "button" },
                                                { label: "Button", type: "button" },
                                            ],
                                        },
                                    ],
                                },
                            ],
                        },
                        {
                            title: "Limitki",
                            type: "section",

                            style: {
                                box: "",
                                elements: "flex justify-around gap-4 flex-wrap flex-col",
                                title: "sticky top-0",
                                imgBox: "relative flex gap-4 flex-wrap",
                                img: "group-hover:scale-110 transition-all",
                                button: "flex",
                                badgeBox: "flex absolute justify-between",
                                action: "bg-green-700",
                                element: "flex justify-between w-full",
                                button: "w-fit",
                            },
                            actions: [
                                {
                                    type: "button",
                                    label: "Zbanuj",
                                },
                                {
                                    type: "button",
                                    label: "Odbanuj",
                                },
                                {
                                    type: "button",
                                    label: "Edytuj",
                                },
                            ],
                            elements: [
                                ...Array(34).fill({
                                    label: "donwwitkrob Zbanowany za (Anticheat) przez Anticheat",
                                    type: "element",
                                }),
                            ],
                        },
                    ],
                },
            ],
        };

        this.alignTypes = {
            center: "top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2",
            top: "top-0",
            left: "left-0",
            bottom: "bottom-0",
            right: "right-0",
            middle: "",
        };
        this.onKey = this.onKey.bind(this);
        this.open = this.open.bind(this);
        this.close = this.close.bind(this);
        this.update = this.update.bind(this);

        this.scroll = this.scroll.bind(this);

        this.scrollSide = this.scrollSide.bind(this);

        this.cancel = this.cancel.bind(this);
        this.submit = this.submit.bind(this);
    }

    update(data) {
        this.setState((state) => {
            const menus = state.menus;
            menus.forEach((v, i) => {
                if (v.name === data.name) {
                    menus[i] = { ...menus[i], ...data };
                }
            });

            return { menus };
        });
    }

    getAlign(align) {
        let newAlign = "";

        if (align.includes("-")) align = align.split("-");
        else newAlign = this.alignTypes[align];

        if (newAlign === "")
            for (let val of align) {
                let newAl = this.alignTypes[val];
                if (newAl) newAlign += newAl + " ";
            }
        return newAlign;
    }

    open(data) {
        console.log(data);
        if (data.elements) data.elements[0].selected = true;
        if (data.isUpdate) return this.update(data);
        if (!data.style) data.style = {};
        if (!data.style.box && data.align) {
            data.style.fixedAlign = this.getAlign(data.align);
        }
        this.setState((state) => {
            const menus = state.menus;
            menus.push(data);
            return { menus };
        });
    }

    submit(data) {
        if (data.name) {
            const menu = this.state.menus.find((v) => v.name === data.name);
            if (menu) {
                const elemId = this.getCurrentSelectedMenuElement(menu);
                const elem = menu.elements[elemId];
                if (elem)
                    sendMessage("menu_submit", {
                        name: data.name,
                        current: elem,
                        pages: menu.pages,
                        currentPage: menu.currentPage,
                    });
            }
        }
    }

    close(data) {
        this.setState((state) => {
            const menus = state.menus.filter((v, i) => v.name !== data.name);

            return { menus };
        });
    }

    cancel(data) {
        sendMessage("menu_cancel", {
            menu: data,
            name: data.name,
        });
    }

    getCurrentSelectedMenuElement(menu) {
        return menu?.elements?.findIndex((v) => v.selected);
    }

    scroll(data) {
        this.setState((state) => {
            const menus = state.menus;
            var menu, menuId;
            menus.forEach((v, i) => {
                if (v.name === data.name) [menu, menuId] = [v, i];
            });
            const currentElementId = this.getCurrentSelectedMenuElement(menu);
            menu.elements[currentElementId].selected = false;
            if (data.up) {
                let newElementId = currentElementId + 1;
                if (newElementId >= menu.elements.length) {
                    menu.elements[0].selected = true;
                } else {
                    menu.elements[newElementId].selected = true;
                }
            } else {
                let newElementId = currentElementId - 1;
                if (newElementId < 0) {
                    menu.elements[menu.elements.length - 1].selected = true;
                } else {
                    menu.elements[newElementId].selected = true;
                }
            }
            return { menus };
        });
    }

    scrollSide(data) {
        this.setState((state) => {
            const menus = state.menus;

            var menu, menuId;
            menus.forEach((v, i) => {
                if (v.name === data.name) [menu, menuId] = [v, i];
            });

            const currentElementId = this.getCurrentSelectedMenuElement(menu);

            const element = menu.elements[currentElementId];

            if (element.type !== "slider") {
                return {};
            }

            let key = element.options ? "indexValue" : "value";

            if (
                element.options &&
                (element.min === undefined ||
                    element.max === undefined ||
                    element.indexValue === undefined)
            ) {
                element.max = element.max || element.options.length - 1;
                element.min = element.min || 0;
                element.indexValue = element.indexValue || 0;
                element.value = element.options[element.indexValue];
            }

            if (data.right) {
                let newValue = element[key] + 1;
                if (newValue > element.max && element.max !== undefined) {
                    newValue = element.min;
                }
                element[key] = newValue;
            } else {
                let newValue = element[key] - 1;
                if (newValue < element.min && element.min !== undefined) {
                    newValue = element.max;
                }
                element[key] = newValue;
            }

            if (element.options) {
                element.value = element.options[element.indexValue];
            }

            return { menus };
        });
    }

    onKey(e) {
        if (true) return;
        console.log(e);
        if (e.key === "Escape") this.cancel();
        if (e.key === "ArrowUp") this.scroll({ up: true, name: "4444brp" });
        else if (e.key === "ArrowDown")
            this.scroll({
                name: "4444brp",
            });
        else if (e.key === "ArrowLeft")
            this.scrollSide({
                name: "4444brp",
            });
        else if (e.key === "ArrowRight")
            this.scrollSide({ right: true, name: "4444brp" });
    }

    compToHex(c) {
        let hex = c.toString(16);
        return hex.length === 1 ? "0" + hex : hex;
    }

    rgbToHex({ r, g, b }) {
        return (
            "#" +
            ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1).toUpperCase()
        );
    }

    hexToRgb(hex) {
        // Remove the hash at the start if it's there
        hex = hex.replace(/^#/, "");

        // Parse r, g, b values
        let bigint = parseInt(hex, 16);
        let r = (bigint >> 16) & 255;
        let g = (bigint >> 8) & 255;
        let b = bigint & 255;

        return { r: r, g: g, b: b };
    }

    filterElements(menu, menuId, element) {
        switch (element.type) {
            case "checkbox": {
                if (element.value)
                    menu.filteredElements = menu.elements.filter((v) => {
                        return v[element.require];
                    });
                else menu.filteredElements = null;
                break;
            }

            case "search": {
                if (element.value !== "")
                    menu.filteredElements = menu.elements.filter((v) => {
                        return v.label?.toLowerCase().includes(element.value);
                    });
                else menu.filteredElements = null;
                break;
            }

            default: {
                break;
            }
        }

        this.setState((state) => {
            const menus = state.menus;
            menus[menuId] = menu;
            return { menus };
        });
    }

    async onChangeValue(event, menu, menuId, element, parentElement, key) {
        let { target } = event;
        if (
            menu.settings?.syncUpdate ||
            element.settings?.syncUpdate ||
            parentElement.settings?.syncUpdate
        ) {
            let cbData = await sendMessage("menu_change", {});
        } else {
            console.log(event);
            this.setState(
                (state) => {
                    const menus = state.menus;
                    const menu = menus[menuId];
                    let keys = key.split("-");
                    console.log(keys, menuId);
                    let keyType = keys.shift();
                    let element = menu;

                    keys.forEach((v, i) => {
                        console.log(element);
                        if (keyType === "filter") element = element.filters[Number(v)];
                        else element = element.elements[Number(v)];
                    });

                    let change = element.change || "uknown";

                    if (!element.firstValue && element.value) {
                        element.firstValue = element.value;
                    }

                    switch (element.type) {
                        case "checkbox": {
                            element.value = target.checked;
                            break;
                        }
                        case "color": {
                            element.value = this.hexToRgb(target.value);

                            if (!element.firstValue) element.firstValue = element.value;
                            if (change === "new" || change === "same") {
                                if (
                                    element.value.r === element.firstValue.r &&
                                    element.value.g === element.firstValue.g &&
                                    element.value.b === element.firstValue.b
                                ) {
                                    change = "back";
                                } else {
                                    change = "same";
                                }
                            } else if (change === "back") {
                                if (
                                    element.value.r !== element.firstValue.r &&
                                    element.value.g !== element.firstValue.g &&
                                    element.value.b !== element.firstValue.b
                                ) {
                                    change = "new";
                                }
                            } else if (change === "uknown") {
                                if (
                                    element.value.r !== element.firstValue.r &&
                                    element.value.g !== element.firstValue.g &&
                                    element.value.b !== element.firstValue.b
                                ) {
                                    change = "new";
                                }
                            }
                            break;
                        }
                        case "select": {
                            element.value = element.options[Number(target.value)];
                            element.lastIndexValue = Number(element.indexValue || 0);
                            element.indexValue = Number(target.value);
                            console.log(
                                element.value,
                                element.lastIndexValue,
                                element.indexValue,
                                element.firstIndexValue,
                            );
                            if (!element.firstIndexValue) {
                                element.firstIndexValue = Number(target.value);
                            }
                            if (change === "new" || change === "same") {
                                if (element.firstIndexValue === element.indexValue) {
                                    change = "back";
                                } else {
                                    change = "same";
                                }
                            } else if (change === "back") {
                                if (element.firstIndexValue !== element.indexValue) {
                                    change = "new";
                                }
                            } else if (change === "uknown") {
                                if (element.firstIndexValue === element.indexValue) {
                                    change = "new";
                                }
                            }
                            break;
                        }
                        default: {
                            element.value = target.value;
                            if (!element.firstValue) element.firstValue = element.value;
                            if (change === "new" || change === "same") {
                                if (element.value === element.firstValue) {
                                    change = "back";
                                } else {
                                    change = "same";
                                }
                            } else if (change === "back") {
                                if (element.value !== element.firstValue) {
                                    change = "new";
                                }
                            } else if (change === "uknown") {
                                if (element.value !== element.firstValue) {
                                    change = "new";
                                }
                            }
                            break;
                        }
                    }

                    console.log(element.type, element.change, change);

                    if (keyType === "filter") {
                        clearTimeout(element.timeout);
                        element.timeout = setTimeout(() => {
                            this.filterElements(menu, menuId, element);
                        }, 400);
                    }

                    element.change = change;

                    return {
                        menus,
                    };
                },
                () => {
                    if (
                        !menu.settings?.noRequest &&
                        !element.settings?.noRequest &&
                        !parentElement.settings?.noRequest
                    ) {
                        sendMessage("menu_change", {
                            current: element,
                            menu: menu,
                        });
                    }
                },
            );
        }
    }

    getHtmlElement(el, elId, menu, menuId, parentElement, parentElementId, key) {
        switch (el.type) {
            case "select": {
                return (
                    <div
                        key={key}
                        className="flex items-center gap-3 flex-wrap justify-center"
                    >
                        <label className="italic" htmlFor={`menu-${menuId}-select-${elId}`}>
                            {el.label}
                        </label>
                        <select
                            id={key}
                            name={`menu-${menuId}-select-${elId}`}
                            className="appearance-none px-1 focus:outline-none bg-black rounded border-green-700 border gap-4 flex flex-col"
                            type="text"
                            value={el.indexValue || el.value}
                            onChange={(e) =>
                                this.onChangeValue(e, menu, menuId, el, parentElement, key)
                            }
                        >
                            {el.options.map((option, optionId) => {
                                return (
                                    <option key={`${key}-option-${optionId}`} value={optionId}>
                                        {option.label}
                                    </option>
                                );
                            })}
                        </select>
                    </div>
                );
            }
            case "color": {
                return (
                    <div key={key} className={`flex gap-1 justify-center items-center`}>
                        <input
                            className="appearance-none bg-green-900 border-green-900 checked:bg-green-500 border-2 w-5 h-5 rounded"
                            type="color"
                            value={this.rgbToHex(el.value ?? "#000000")}
                            onChange={(e) =>
                                this.onChangeValue(e, menu, menuId, el, parentElement, key)
                            }
                        />
                        <label>{el.label}</label>
                    </div>
                );
            }
            case "textarea": {
                return (
                    <div key={key} className="flex justify-center items-center ">
                        <textarea
                            placeholder={el.label}
                            className="bg-black max-w-full rounded border-green-700 border focus:outline-none p-0.5"
                        ></textarea>
                    </div>
                );
            }
            case "date": {
                return (
                    <div
                        key={key}
                        className="flex items-center gap-3 flex-wrap justify-center"
                    >
                        {
                            <label htmlFor={`menu-${menuId}-number-${elId}`}>
                                {el.label}
                            </label>
                        }
                        <input
                            id={`menu-${menuId}-number-${elId}`}
                            type="date"
                            className="border-2 max-w-full bg-black border-green-700 checked:bg-green-400 rounded focus:outline-none"
                        />
                    </div>
                );
            }
            case "radio": {
                return (
                    <div
                        key={key}
                        className="flex items-center gap-3 flex-wrap justify-center"
                    >
                        {
                            <label htmlFor={`menu-${menuId}-number-${elId}`}>
                                {el.label}
                            </label>
                        }
                        <input
                            id={`menu-${menuId}-number-${elId}`}
                            type="radio"
                            className="appearance-none border-2 w-5 h-5 bg-black border-green-700 checked:bg-green-400 rounded-full"
                        />
                    </div>
                );
            }

            case "range": {
                return (
                    <div
                        key={key}
                        className="flex items-center gap-3 flex-wrap justify-center"
                    >
                        {
                            <label htmlFor={`menu-${menuId}-number-${elId}`}>
                                {el.label}
                            </label>
                        }
                        <input
                            id={`menu-${menuId}-number-${elId}`}
                            type="range"
                            className="appearance-none max-w-full focus:outline-none border-2 bg-black border-green-700 checked:bg-green-400 h-5 rounded-lg"
                            min={el.min}
                            max={el.max}
                            step={el.step}
                            onChange={(e) =>
                                this.onChangeValue(e, menu, menuId, el, parentElement, key)
                            }
                            value={el.value}
                        />
                        <input
                            id={`menu-${menuId}-number-${elId}`}
                            type="number"
                            className="appearance-none max-w-full focus:outline-none border-2 bg-black border-green-700 checked:bg-green-400 w-14 h-5 rounded"
                            value={el.value}
                        />
                    </div>
                );
            }
            case "progbar": {
                return <Progbar el={el} menuId={menuId} key={key} elId={elId} />;
            }
            case "number": {
                return (
                    <div
                        key={key}
                        className="flex items-center gap-3 flex-wrap justify-center"
                    >
                        {
                            <label htmlFor={`menu-${menuId}-number-${elId}`}>
                                {el.label}
                            </label>
                        }
                        <input
                            id={`menu-${menuId}-number-${elId}`}
                            type="number"
                            className="appearance-none max-w-full focus:outline-none border-2 bg-black border-green-700 checked:bg-green-400 w-14 h-5 rounded"
                        />
                    </div>
                );
            }
            case "range-number": {
                return (
                    <div
                        key={key}
                        className="flex items-center gap-3 flex-wrap justify-center"
                    >
                        {<div className="italic">{el.label}</div>}
                        {
                            <label htmlFor={`menu-${menuId}-checkbox-${elId}`}>
                                {el.fromLabel}
                            </label>
                        }
                        <input
                            id={`menu-${menuId}-checkbox-${elId}`}
                            type="number"
                            className="appearance-none focus:outline-none border-2 bg-black border-green-700 checked:bg-green-400 w-14 h-5 rounded"
                        />
                        {
                            <label htmlFor={`menu-${menuId}-checkbox-${elId}`}>
                                {el.toLabel}
                            </label>
                        }
                        <input
                            id={`menu-${menuId}-checkbox-${elId}`}
                            type="number"
                            className="appearance-none focus:outline-none border-2 bg-black border-green-700 checked:bg-green-400 w-14 h-5 rounded"
                        />
                    </div>
                );
            }
            case "table": {
                return (
                    <div key={key} className={`max-w-full `}>
                        <table
                            className={`${el.style?.table ?? parentElement?.style?.table} table-fixed w-full`}
                        >
                            <thead
                                className={`${el.style?.thead ?? parentElement?.style?.thead}`}
                            >
                                <tr>
                                    {el.rows.map((row, rowId) => {
                                        return <th key={`${key}-row-${rowId}`}>{row.label}</th>;
                                    })}
                                </tr>
                            </thead>
                            <tbody
                                className={`${el.style?.tbody ?? parentElement?.style?.tbody}`}
                            >
                                {el.elements.map((item, itemId) => {
                                    return (
                                        <tr key={`${key}-item-${itemId}`}>
                                            {item.rows.map((row, rowId) => {
                                                return (
                                                    <td key={`${key}-td-row-${rowId}`}>
                                                        {this.getHtmlElement(
                                                            row,
                                                            rowId,
                                                            menu,
                                                            menuId,
                                                            el,
                                                            elId,
                                                            `${key}-${rowId}`,
                                                        )}
                                                    </td>
                                                );
                                            })}
                                        </tr>
                                    );
                                })}
                            </tbody>
                        </table>
                    </div>
                );
            }
            case "checkbox": {
                return (
                    <div key={key} className="flex items-center gap-3">
                        {el.fromRight && (
                            <label htmlFor={`menu-${menuId}-checkbox-${elId}`}>
                                {el.label}
                            </label>
                        )}
                        <input
                            id={`menu-${menuId}-checkbox-${elId}`}
                            defaultChecked={el.value}
                            type="checkbox"
                            className="appearance-none transition-all border-2 bg-black border-green-700 checked:bg-green-400 w-5 h-5 rounded"
                            onChange={(e) =>
                                this.onChangeValue(e, menu, menuId, el, parentElement, key)
                            }
                        />
                        {!el.fromRight && (
                            <label htmlFor={`menu-${menuId}-checkbox-${elId}`}>
                                {el.label}
                            </label>
                        )}
                    </div>
                );
            }
            case "search": {
                return (
                    <div
                        onChange={(e) =>
                            this.onChangeValue(e, menu, menuId, el, parentElement, key)
                        }
                        key={key}
                        className="flex justify-center items-center"
                    >
                        <div className="relative w-fit border rounded border-green-700">
                            <input
                                placeholder={el.label}
                                type="search"
                                className="peer block font-normal max-w-full pl-7 w-full text-sm text-white  rounded-lg border border-black bg-black bg-opacity-70 focus:outline-none"
                            />

                            <div className="flex peer-focus:animate-wiggle absolute left-0 top-0 items-center pointer-events-none">
                                <svg
                                    aria-hidden="true"
                                    className="w-5 h-5 text-gray-500 dark:text-gray-400"
                                    fill="none"
                                    stroke="currentColor"
                                    viewBox="0 0 24 24"
                                    xmlns="http://www.w3.org/2000/svg"
                                >
                                    <path
                                        strokeLinecap="round"
                                        strokeLinejoin="round"
                                        strokeWidth="2"
                                        d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z"
                                    ></path>
                                </svg>
                            </div>
                        </div>
                    </div>
                );
            }
            case "img": {
                return (
                    <div
                        key={key}
                        className={el.style?.imgBox ?? parentElement?.style?.imgBox}
                    >
                        <img
                            className={el.style?.img ?? parentElement?.style?.img}
                            src={el.img}
                            alt={el.label}
                        />
                    </div>
                );
            }
            case "text": {
                return (
                    <div key={key} className="flex justify-center items-center ">
                        <input
                            className={`appearance-none max-w-full block text-center outline-none border border-green-700 rounded bg-black`}
                            placeholder={el.label}
                            type="text"
                        />
                    </div>
                );
            }
            case "section": {
                let style = el.style;
                return (
                    <div key={key} className={style.box}>
                        {el.title && (
                            <div
                                className={`${style.title} bg-green-400 text-black font-bold flex w-full `}
                            >
                                <button className="w-5">
                                    <svg
                                        viewBox="0 0 24 24"
                                        fill="none"
                                        xmlns="http://www.w3.org/2000/svg"
                                    >
                                        <path
                                            d="M9 14L12 17L15 14M15 10L12 7L9 10M21 12C21 16.9706 16.9706 21 12 21C7.02944 21 3 16.9706 3 12C3 7.02944 7.02944 3 12 3C16.9706 3 21 7.02944 21 12Z"
                                            stroke="currentColor"
                                            strokeWidth="1.5"
                                            strokeLinecap="round"
                                            strokeLinejoin="round"
                                        />
                                    </svg>
                                </button>
                                <div
                                    className="self-center justify-self-center w-full"
                                    dangerouslySetInnerHTML={{ __html: el.title }}
                                ></div>
                            </div>
                        )}
                        {!el.hideElements && el.elements && (
                            <div className={`${style.elements} flex gap-4 justify-center `}>
                                {(el.filteredElements ?? el.elements).map(
                                    (sectionElem, sectionElemId) => {
                                        return this.getHtmlElement(
                                            sectionElem,
                                            sectionElemId,
                                            menu,
                                            menuId,
                                            el,
                                            elId,
                                            `${key}-${sectionElemId}`,
                                        );
                                    },
                                )}
                            </div>
                        )}
                    </div>
                );
            }
            case "element": {
                return (
                    <div
                        key={key}
                        type={el.type}
                        className={`${el.style?.element ?? parentElement?.style?.element} flex flex-wrap justify-around`}
                    >
                        {el.img && (
                            <div className={el.style?.imgBox ?? parentElement?.style?.imgBox}>
                                <img
                                    className={el.style?.img ?? parentElement?.style?.img}
                                    src={el.img}
                                    alt={el.label}
                                />
                                <div
                                    className={`${el.style?.badgeBox ?? parentElement?.style?.badgeBox} w-full h-full absolute flex gap-3`}
                                >
                                    {(el.badges ?? parentElement?.badges)?.map(
                                        (badge, badgeId) => {
                                            return (
                                                <div
                                                    key={`${key}-badge-${badgeId}`}
                                                    className={`${el.style?.badge ?? parentElement?.style?.badge ?? badge.style} text-sm font-bold w-fit h-fit p-0.5 rounded-lg bg-green-700 text-green-400`}
                                                >
                                                    {badge.label}
                                                </div>
                                            );
                                        },
                                    )}
                                </div>
                            </div>
                        )}
                        {el.label && (
                            <div
                                type={el.type}
                                className={`flex ${el.selected && "bg-green-900"} ${el.style && el.style} `}
                                dangerouslySetInnerHTML={{ __html: el.label }}
                            ></div>
                        )}
                        {(el.subLabels ?? parentElement.subLabels) && (
                            <div className={`w-full `}>
                                <ul className="flex justify-between flex-wrap break-words list-disc ">
                                    {(el.subLabels ?? parentElement.subLabels).map(
                                        (label, labelId) => {
                                            return (
                                                <li
                                                    key={`${key}-labels-${labelId}`}
                                                    className={label.style}
                                                >
                                                    {label.label}
                                                </li>
                                            );
                                        },
                                    )}
                                </ul>
                            </div>
                        )}
                        {(el.actions ?? parentElement.actions) && (
                            <div className={`flex flex-wrap `}>
                                <div
                                    className={`${el.style?.actions ?? parentElement.style?.actions} flex flex-wrap justify-around w-full gap-4 `}
                                >
                                    {(el.actions ?? parentElement.actions).map(
                                        (action, actionId) => {
                                            return this.getHtmlElement(
                                                action,
                                                actionId,
                                                menu,
                                                menuId,
                                                el,
                                                elId,
                                                `${key}-${actionId}`,
                                            );
                                        },
                                    )}
                                </div>
                            </div>
                        )}
                    </div>
                );
            }
            case "slider": {
                return (
                    <div
                        key={key}
                        type={el.type}
                        className={`${el.selected && "bg-green-900"} ${el.style?.button ?? parentElement?.style?.button} w-full max-w-full break-all flex justify-center gap-1`}
                    >
                        {el.img && (
                            <div className={el.style?.imgBox ?? parentElement?.style?.imgBox}>
                                <img
                                    className={el.style?.img ?? parentElement?.style?.img}
                                    src={el.img}
                                    alt={el.label}
                                />
                                <div
                                    className={`${el.style?.badgeBox ?? parentElement?.style?.badgeBox} w-full h-full absolute flex gap-3`}
                                >
                                    {(el.badges ?? parentElement?.badges)?.map(
                                        (badge, badgeId) => {
                                            return (
                                                <div
                                                    key={`${key}-badge-slider-${badgeId}`}
                                                    className={`${el.style?.badge ?? parentElement?.style?.badge ?? badge.style} text-sm font-bold w-fit h-fit p-0.5 rounded-lg bg-green-700 text-green-400`}
                                                >
                                                    {badge.label}
                                                </div>
                                            );
                                        },
                                    )}
                                </div>
                            </div>
                        )}
                        <button>{"<"}</button>
                        {el.label && (
                            <div
                                type={el.type}
                                className={`${el.style && el.style} `}
                                dangerouslySetInnerHTML={{ __html: el.label }}
                            ></div>
                        )}
                        {el.options ? (
                            <div>{el.value?.label ?? el.options[el.value ?? 0].label}</div>
                        ) : (
                            <div>
                                {el.value}/{el.max}
                            </div>
                        )}
                        <button>{">"}</button>
                        {(el.subLabels ?? parentElement.subLabels) && (
                            <div className={`w-full max-w-full`}>
                                <ul className="flex justify-between flex-wrap break-words list-disc max-w-full">
                                    {(el.subLabels ?? parentElement.subLabels).map(
                                        (label, labelId) => {
                                            return (
                                                <li
                                                    key={`${key}-labels-sub-${labelId}`}
                                                    className={label.style}
                                                >
                                                    {label.label}
                                                </li>
                                            );
                                        },
                                    )}
                                </ul>
                            </div>
                        )}
                        {(el.actions ?? parentElement.actions) && (
                            <div className={`w-full max-w-full flex flex-wrap`}>
                                <div
                                    className={`${el.style?.actions} flex flex-wrap max-w-full`}
                                >
                                    {(el.actions ?? parentElement.actions).map(
                                        (action, actionId) => {
                                            return this.getHtmlElement(
                                                action,
                                                actionId,
                                                menu,
                                                menuId,
                                                el,
                                                elId,
                                                `${key}-${actionId}`,
                                            );
                                        },
                                    )}
                                </div>
                            </div>
                        )}
                    </div>
                );
            }
            default: {
                return (
                    <button
                        key={key}
                        type={el.type}
                        className={`${el.style?.button ?? parentElement?.style?.button} max-w-full break-all`}
                    >
                        {el.img && (
                            <div className={el.style?.imgBox ?? parentElement?.style?.imgBox}>
                                <img
                                    className={el.style?.img ?? parentElement?.style?.img}
                                    src={el.img}
                                    alt={el.label}
                                />
                                <div
                                    className={`${el.style?.badgeBox ?? parentElement?.style?.badgeBox} w-full h-full absolute flex gap-3`}
                                >
                                    {(el.badges ?? parentElement?.badges)?.map(
                                        (badge, badgeId) => {
                                            return (
                                                <div
                                                    key={`${key}-bages-button-${badgeId}`}
                                                    className={`${el.style?.badge ?? parentElement?.style?.badge ?? badge.style} text-sm font-bold w-fit h-fit p-0.5 rounded-lg bg-green-700 text-green-400`}
                                                >
                                                    {badge.label}
                                                </div>
                                            );
                                        },
                                    )}
                                </div>
                            </div>
                        )}
                        {el.label && (
                            <div
                                type={el.type}
                                className={`w-full ${el.selected && "bg-green-900"} ${el.style && el.style} `}
                                dangerouslySetInnerHTML={{ __html: el.label }}
                            ></div>
                        )}
                        {(el.subLabels ?? parentElement.subLabels) && (
                            <div className={`w-full max-w-full`}>
                                <ul className="flex justify-between flex-wrap break-words list-disc max-w-full">
                                    {(el.subLabels ?? parentElement.subLabels).map(
                                        (label, labelId) => {
                                            return (
                                                <li
                                                    key={`${key}-labels-sub-elem-${labelId}`}
                                                    className={label.style}
                                                >
                                                    {label.label}
                                                </li>
                                            );
                                        },
                                    )}
                                </ul>
                            </div>
                        )}
                        {(el.actions ?? parentElement.actions) && (
                            <div className={`w-full max-w-full flex flex-wrap`}>
                                <div
                                    className={`${el.style?.actions} flex flex-wrap max-w-full`}
                                >
                                    {(el.actions ?? parentElement.actions).map(
                                        (action, actionId) => {
                                            return this.getHtmlElement(
                                                action,
                                                actionId,
                                                menu,
                                                menuId,
                                                el,
                                                elId,
                                                `${key}-${actionId}`,
                                            );
                                        },
                                    )}
                                </div>
                            </div>
                        )}
                    </button>
                );
            }
        }
    }

    isInViewport(element, height, width) {
        const rect = element.getBoundingClientRect();
        return (
            rect.top >= 0 &&
            rect.left >= 0 &&
            rect.bottom <=
            (window.innerHeight || document.documentElement.clientHeight) &&
            rect.right <= (window.innerWidth || document.documentElement.clientWidth)
        );
    }

    onMouseDownMenu = (e, i) => {
        if (this.currentMenu) this.currentMenu.style.zIndex = "";
        this.currentMenu = document.getElementById(`menu-${i}`);
        this.currentMenu.style.zIndex = "40";
    };

    onMouseDown = (e, i) => {
        if (this.currentMenu) this.currentMenu.style.zIndex = "";
        this.currentMenu = document.getElementById(`menu-${i}`);
        this.mouseDown = true;
        this.offsetX = e.clientX - this.currentMenu.offsetLeft;
        this.offsetY = e.clientY - this.currentMenu.offsetTop;
        this.currentMenu.style.zIndex = "40";
    };

    onMouseUp = (e) => {
        this.mouseDown = false;
    };

    onMouseMove = (event) => {
        if (this.mouseDown) {
            var dot, eventDoc, doc, body, pageX, pageY;

            event = event || window.event; // IE-ism

            // If pageX/Y aren't available and clientX/Y
            // are, calculate pageX/Y - logic taken from jQuery
            // Calculate pageX/Y if missing and clientX/Y available
            if (event.pageX == null && event.clientX != null) {
                eventDoc = (event.target && event.target.ownerDocument) || document;
                doc = eventDoc.documentElement;
                body = eventDoc.body;

                event.pageX =
                    event.clientX +
                    ((doc && doc.scrollLeft) || (body && body.scrollLeft) || 0) -
                    ((doc && doc.clientLeft) || (body && body.clientLeft) || 0);
                event.pageY =
                    event.clientY +
                    ((doc && doc.scrollTop) || (body && body.scrollTop) || 0) -
                    ((doc && doc.clientTop) || (body && body.clientTop) || 0);
            }
            let rect = event.target.getBoundingClientRect();
            console.log(rect, event.pageY, event.pageX);
            let lastX = this.currentMenu.style.left;
            let lastY = this.currentMenu.style.top;
            let targetX = event.clientX - this.offsetX;
            let targetY = event.clientY - this.offsetY;

            this.currentMenu.style.left = targetX + "px";
            if (!this.isInViewport(this.currentMenu)) {
                this.currentMenu.style.left = lastX;
            }

            this.currentMenu.style.top = targetY + "px";
            if (!this.isInViewport(this.currentMenu)) {
                this.currentMenu.style.top = lastY;
            }
        }
    };

    closeMenuUI(menuId) {
        this.setState({ ...this.state.menus.filter((_, i) => i !== menuId) });
    }

    onCloseMenuButton = (e, menuId) => {
        e.preventDefault();
        const menu = this.state.menus[menuId];
        if (menu.settings.syncClose) {
            const cb = sendMessage("menu_close", {
                menu: menu,
            });
            if (cb.close === true) {
                this.closeMenuUI(menuId);
            } else {
            }
        } else {
            sendMessage("menu_close", {
                menu: menu,
            });
        }
    };

    onResizeMenuButton = (e, menuId) => {
        e.preventDefault();
        e.target.value = !e.target.value;
        this.setState((state) => {
            const menus = state.menus;
            console.log(menuId, menus[menuId].isFullscreen);
            menus[menuId].isFullscreen = e.target.value;
            return { menus };
        });
    };

    onHideWindowButton = (e, menuId) => {
        e.preventDefault();
        this.setState((state) => {
            const menus = state.menus;
            console.log(menuId);
            menus[menuId].hideAllElements = !menus[menuId].hideAllElements;
            return { menus };
        });
    };

    onHideSectionButton = (e, menuId, key) => {
        e.preventDefault();
    };

    runResizeObserver() {
        this.ro?.disconnect();

        this.ro = new ResizeObserver((entries) => {
            for (let entry of entries) {
                console.log(entry.target);
            }
        });

        document.getElementById("menus")?.childNodes.forEach((child) => {
            this.ro.observe(child);
        });
    }

    componentDidMount() {
        this.runResizeObserver();
    }

    componentDidUpdate() {
        this.runResizeObserver();
    }

    onChangePageButton(menuId, n) {
        this.setState((state) => {
            const menus = state.menus;
            const menu = menus[menuId];
            let currentPage = menu.currentPage;
            let nextPage = currentPage + n;
            if (nextPage < 0) {
                nextPage = menu.pages.length;
            }
            if (nextPage > menu.pages.length) {
                nextPage = 0;
            }
            menu.currentPage = nextPage;
            return {
                menus,
            };
        });
    }

    render() {
        if (this.state.menus.length <= 0) return <></>;
        return (
            <div
                id="menus"
                className="w-full h-full select-none z-20 relative "
                onMouseMove={this.onMouseMove}
                onMouseUp={this.onMouseUp}
            >
                {this.state.menus.map((v, i) => {
                    return (
                        !v.hidden && (
                            <div
                                key={`menu-${i}`}
                                id={`menu-${i}`}
                                onMouseDown={(e) => this.onMouseDownMenu(e, i)}
                                className={` ${v.style?.box ?? "min-w-1/5 w-1/5 min-h-1/4 max-w-full max-h-full m-0.5"} ${v.style?.fixedAlign}  bg-black bg-opacity-80 flex flex-col justify-center items-center rounded-lg font-sans absolute resize overflow-auto backdrop-blur `}
                                data-ismenu={true}
                                data-menuid={i}
                            >
                                <div
                                    onMouseDown={(e) => this.onMouseDown(e, i)}
                                    className="w-full h-auto bg-green-400 text-black rounded-t-lg text-center sticky top-0 text-lg font-bold "
                                >
                                    <div dangerouslySetInnerHTML={{ __html: v.title }}></div>
                                    {v.settings?.windowButtons && (
                                        <div className="absolute right-0.5 top-0.5 flex gap-0.5">
                                            <button
                                                className="w-6 h-6"
                                                onClick={(e) => this.onHideWindowButton(e, i)}
                                            >
                                                <svg
                                                    className="w-full h-full text-green-900 "
                                                    viewBox="0 0 24 24"
                                                    fill="currentCOlor"
                                                    xmlns="http://www.w3.org/2000/svg"
                                                >
                                                    <path d="M7 11H17V13H7V11Z" fill="currentCOlor" />
                                                    <path
                                                        fillRule="evenodd"
                                                        clipRule="evenodd"
                                                        d="M12 22C17.5228 22 22 17.5228 22 12C22 6.47715 17.5228 2 12 2C6.47715 2 2 6.47715 2 12C2 17.5228 6.47715 22 12 22ZM12 20C16.4183 20 20 16.4183 20 12C20 7.58172 16.4183 4 12 4C7.58172 4 4 7.58172 4 12C4 16.4183 7.58172 20 12 20Z"
                                                        fill="currentCOlor"
                                                    />
                                                </svg>
                                            </button>
                                            <button
                                                className="w-6 h-6"
                                                onClick={(e) => this.onResizeMenuButton(e, i)}
                                            >
                                                <svg
                                                    className="w-full h-full text-green-900"
                                                    viewBox="0 0 24 24"
                                                    fill="none"
                                                    xmlns="http://www.w3.org/2000/svg"
                                                >
                                                    <path
                                                        fillRule="evenodd"
                                                        clipRule="evenodd"
                                                        d="M12 23C18.0751 23 23 18.0751 23 12C23 5.92487 18.0751 1 12 1C5.92487 1 1 5.92487 1 12C1 18.0751 5.92487 23 12 23ZM21 12C21 16.9706 16.9706 21 12 21C7.02944 21 3 16.9706 3 12C3 7.02944 7.02944 3 12 3C16.9706 3 21 7.02944 21 12ZM6.31724 6.28282L10.3172 6.2828V8.2828H9.73133L12.0201 10.5716L14.1172 8.47451H13.5315V6.47451L17.5315 6.47453L17.5315 10.4745L15.5315 10.4745V9.88861L13.4343 11.9858L15.3681 13.9196V13.3741L17.3681 13.3741L17.3682 17.374H13.3682L13.3682 15.374H13.9941L12.0201 13.4L9.89472 15.5254H10.4402L10.4402 17.5254L6.4403 17.5255V13.5255L8.44031 13.5255L8.4403 14.1514L10.6059 11.9858L8.31722 9.69712V10.2828H6.31722L6.31724 6.28282Z"
                                                        fill="currentCOlor"
                                                    />
                                                </svg>
                                            </button>
                                            <button className="w-6 h-6">
                                                <svg
                                                    className="w-full h-full text-green-900 font-bold"
                                                    viewBox="0 0 24 24"
                                                    fill="none"
                                                    xmlns="http://www.w3.org/2000/svg"
                                                >
                                                    <circle
                                                        cx="12"
                                                        cy="12"
                                                        r="10"
                                                        stroke="currentCOlor"
                                                        strokeWidth="1.5"
                                                    />
                                                    <path
                                                        d="M14.5 9.50002L9.5 14.5M9.49998 9.5L14.5 14.5"
                                                        stroke="currentCOlor"
                                                        strokeWidth="1.5"
                                                        strokeLinecap="round"
                                                    />
                                                </svg>
                                            </button>
                                        </div>
                                    )}
                                </div>
                                {v.filters && (
                                    <div className="w-full h-auto text-black rounded-t-lg text-center sticky top-0 text-lg font-bold flex gap-4 flex-wrap p-1 items-center">
                                        {v.filters && (
                                            <div
                                                className={`${v.style.filters} flex flex-wrap justify-center items-center gap-4 text-green-400 text-md font-normal`}
                                            >
                                                {v.filters.map((check, checkId) => {
                                                    return this.getHtmlElement(
                                                        check,
                                                        checkId,
                                                        v,
                                                        i,
                                                        v,
                                                        i,
                                                        `filter-${checkId}`,
                                                    );
                                                })}
                                            </div>
                                        )}
                                    </div>
                                )}
                                <div
                                    className={` ${v.style?.elements ?? "flex flex-col overflow-auto gap-1"} w-full h-full  text-lg text-green-400 text-center break-words `}
                                >
                                    {console.log(
                                        v.pages,
                                        v.currentPage,
                                        v.pages && v.pages[v.currentPage],
                                    )}
                                    {!v.pages
                                        ? (v.filteredElements ?? v.elements).map((e, eId) => {
                                            return this.getHtmlElement(
                                                e,
                                                eId,
                                                v,
                                                i,
                                                v,
                                                i,
                                                `${v.type ?? "none"}-${eId}`,
                                            );
                                        })
                                        : v.pages[v.currentPage].map((e, eId) => {
                                            return this.getHtmlElement(
                                                e,
                                                eId,
                                                v,
                                                i,
                                                v,
                                                i,
                                                `${v.type ?? "none"}-${eId}`,
                                            );
                                        })}

                                    {v.pages && (
                                        <div className="w-full h-auto sticky bottom-0 flex justify-between p-4 flex-wrap bg-black bg-opacity-90">
                                            <button onClick={(e) => this.onChangePageButton(i, -1)}>
                                                Poprzednia
                                            </button>
                                            <input
                                                className="appearance-none bg-transparent w-14"
                                                type="number"
                                                value={v.currentPage}
                                            />
                                            <button onClick={(e) => this.onChangePageButton(i, 1)}>
                                                Następna
                                            </button>

                                            <div className="h-auto w-full flex flex-col gap-0.5">
                                                <div className="w-full h-auto rounded-lg text-white flex flex-col gap-1 px-0.5 bg-gray-900">
                                                    <div className="flex gap-1 items-center px-0.5 ">
                                                        <div className="w-7 h-7 flex items-center">
                                                            <svg
                                                                className="w-full h-full"
                                                                viewBox="-0.5 0 25 25"
                                                                fill="none"
                                                                xmlns="http://www.w3.org/2000/svg"
                                                            >
                                                                <path
                                                                    d="M12 21.5C17.1086 21.5 21.25 17.3586 21.25 12.25C21.25 7.14137 17.1086 3 12 3C6.89137 3 2.75 7.14137 2.75 12.25C2.75 17.3586 6.89137 21.5 12 21.5Z"
                                                                    stroke="currentColor"
                                                                    stroke-width="1.5"
                                                                    stroke-linecap="round"
                                                                    stroke-linejoin="round"
                                                                />
                                                                <path
                                                                    d="M12.9309 8.15005C12.9256 8.39231 12.825 8.62272 12.6509 8.79123C12.4767 8.95974 12.2431 9.05271 12.0008 9.05002C11.8242 9.04413 11.6533 8.98641 11.5093 8.884C11.3652 8.7816 11.2546 8.63903 11.1911 8.47415C11.1275 8.30927 11.1139 8.12932 11.152 7.95675C11.19 7.78419 11.278 7.6267 11.405 7.50381C11.532 7.38093 11.6923 7.29814 11.866 7.26578C12.0397 7.23341 12.2192 7.25289 12.3819 7.32181C12.5446 7.39072 12.6834 7.506 12.781 7.65329C12.8787 7.80057 12.9308 7.97335 12.9309 8.15005ZM11.2909 16.5301V11.1501C11.2882 11.0556 11.3046 10.9615 11.3392 10.8736C11.3738 10.7857 11.4258 10.7057 11.4922 10.6385C11.5585 10.5712 11.6378 10.518 11.7252 10.4822C11.8126 10.4464 11.9064 10.4286 12.0008 10.43C12.094 10.4299 12.1863 10.4487 12.272 10.4853C12.3577 10.5218 12.4352 10.5753 12.4997 10.6426C12.5642 10.7099 12.6143 10.7895 12.6472 10.8767C12.6801 10.9639 12.6949 11.0569 12.6908 11.1501V16.5301C12.6908 16.622 12.6727 16.713 12.6376 16.7979C12.6024 16.8828 12.5508 16.96 12.4858 17.025C12.4208 17.09 12.3437 17.1415 12.2588 17.1767C12.1738 17.2119 12.0828 17.23 11.9909 17.23C11.899 17.23 11.8079 17.2119 11.723 17.1767C11.6381 17.1415 11.5609 17.09 11.4959 17.025C11.4309 16.96 11.3793 16.8828 11.3442 16.7979C11.309 16.713 11.2909 16.622 11.2909 16.5301Z"
                                                                    fill="currentColor"
                                                                />
                                                            </svg>
                                                        </div>
                                                        <div>Cena</div>
                                                    </div>
                                                    <div>Lorem ipsum....</div>
                                                </div>
                                            </div>
                                        </div>
                                    )}

                                    {v.settings?.saveButtons && (
                                        <div className="w-full h-auto sticky bottom-0 flex justify-between p-4 flex-wrap bg-black bg-opacity-90 ">
                                            <button>Anuluj</button>
                                            <button>Zapisz</button>
                                        </div>
                                    )}
                                </div>
                            </div>
                        )
                    );
                })}
            </div>
        );
    }
}
