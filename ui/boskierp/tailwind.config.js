module.exports = {
  content: ["./src/**/*.{js,jsx,ts,tsx}"],
  theme: {
    extend: {
      animation: {
        wiggle: "wiggle 1s ease-in-out infinite",
        wiggle4: "wiggle4 1s ease-in-out infinite",
        rainbowtxt: "rainbowtxt 5s ease-in-out infinite",

        units: "units 0.5s steps(100) forwards 10",
        tens: "units 5s steps(10) forwards 1",
        hun: "units 5s steps(1) forwards 1",
        rainbowborder: "rainbowborder 5s ease-in-out infinite",
        rainbowdiv: "rainbowdiv 5s ease-in-out infinite",
        rainbow: "rainbow 5s ease infinite",
        rainbowborder: "rainbowborder 5s ease infinite",
        rotn: "rotn 5s ease infinite",
        scale: "scale 5s ease infinite",
        fadeIn: "fadeIn 5s ease-in-out 1",
        fadeOut: "fadeOut 5s ease-in-out 1",
        fadeInFast: "fadeIn 500ms ease-in-out 1",
        wave2: "wave2 4s -1s linear infinite",
        scrollin: "scrollin 500ms ease-in-out 1",
        toRight: "toRight 500ms ease-in-out 1",
        toRightOut: "toRightOut 500ms ease-in-out 1",
        toLeft: "toLeft 500ms ease-in-out 1",

        ping4: "ping4 3s ease infinite",
        cursor: "cursor 500ms ease infinite",
        write: "write 5s ease-in-out 700ms infinite",
        write4: "write 3s ease-in-out 700ms infinite",
        height: "height 500ms ease-in-out 1",

        width: "width 4s ease-out forward",

        disappear: "disappear 500ms ease-in-out 1",
      },
      keyframes: {
        units: {
          "0%": {
            transform: "translateY(-1000%)",
          },
          // '50%': {
          // transform: "translateY(-500%)"
          // },
          "100%": {
            transform: "translateY(0%)",
          },
        },
        width: {
          "0%": {
            width: 0,
          },
          "50%": {
            width: "50%",
          },
          "100%": {
            width: "100%",
          },
        },
        height: {
          "0%": {
            height: 0,
          },
          "50%": {
            height: "50%",
          },
          "100%": {
            height: "100%",
          },
        },
        ping4: {
          "0%": {
            opacity: 0.0,
          },
          "50%": {
            opacity: 1.0,
          },
          "100%": {
            opacity: 0.0,
          },
        },
        cursor: {
          "0%": {
            opacity: 0.0,
          },
          "50%": {
            opacity: 1.0,
          },
          "100%": {
            opacity: 0.0,
          },
        },
        write: {
          "0%": {
            width: "0%",
          },
          "50%": {
            width: "100%",
          },
          "100%": {
            width: "0%",
          },
        },
        wave2: {
          "0%": {
            transform: "translateX(-5%) translateY(5%)",
          },
          "50%": {
            transform: "translateX(-15%) translateY(-10%)",
          },
          "100%": {
            transform: "translateX(-5%) translateY(5%)",
          },
        },
        wiggle4: {
          "0%, 100%": { transform: "rotate(-3deg)" },
          "50%": { transform: "rotate(3deg)" },
        },
        toRight: {
          "0%": {
            transform: "translateX(-50%)",
          },
          // '50%': {
          //     transform: "translateX(-33%)"
          // },
          "100%": {
            transform: "translateX(0%)",
          },
        },

        toRightOut: {
          "0%": {
            transform: "translateX(0%)",
          },
          // '50%': {
          //     transform: "translateX(-33%)"
          // },
          "100%": {
            transform: "translateX(100%)",
          },
        },
        toLeft: {
          "0%": {
            transform: "translateX(50%)",
          },
          // '50%': {
          //     transform: "translateX(-33%)"
          // },
          "100%": {
            transform: "translateX(0%)",
          },
        },
        scrollin: {
          "0%": { maxHeight: 0 },
          "50%": { opacity: 0.5, maxHeight: "50%" },
          "100%": { opacity: 0.77, maxHeight: "100%" },
        },
        fadeIn: {
          "0%": { opacity: 0 },
          "50%": { opacity: 0.5 },
          "100%": { opacity: 1 },
        },

        fadeOut: {
          "100%": { opacity: 0 },
          "50%": { opacity: 0.5 },
          "0%": { opacity: 1 },
        },
        disappear: {
          "100%": { opacity: 0, height: 0 },
          "50%": { opacity: 0.5 },
          "0%": { opacity: 1 },
        },

        scale: {
          "50%": { scale: "50%" },
          "0%, 100%": { scale: "100%" },
        },
        rotn: {
          "50%": { rotate: "135deg" },
          "0%, 100%": { rotate: "0deg" },
        },
        rainbowborder: {
          "0%, 100%": { borderColor: "green" },
          "25%": { borderColor: "yellow" },
          "50%": { borderColor: "purple" },
          "75%": { borderColor: "orange" },
        },
        rainbowtxt: {
          "0%, 100%": { color: "green" },
          "25%": { color: "yellow" },
          "50%": { color: "purple" },
          "75%": { color: "orange" },
        },
        rainbowdiv: {
          "0%, 100%": { backgroundColor: "green" },
          "25%": { backgroundColor: "yellow" },
          "50%": { backgroundColor: "purple" },
          "75%": { backgroundColor: "orange" },
        },

        rainbowborder: {
          "0%, 100%": { borderColor: "green" },
          "25%": { borderColor: "yellow" },
          "50%": { borderColor: "purple" },
          "75%": { borderColor: "orange" },
        },
        wiggle: {
          "0%, 100%": { transform: "rotate(-3deg)" },
          "50%": { transform: "rotate(3deg)" },
        },
        rainbow: {
          "0%, 100%": {
            "background-size": "200% 200%",
            "background-position": "left center",
          },
          "50%": {
            "background-size": "200% 200%",
            "background-position": "right center",
          },
        },
      },
    },
  },
  plugins: [],
};
