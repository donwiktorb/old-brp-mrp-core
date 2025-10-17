import React, { useEffect, useState } from "react";
export default function Progbar({ key, el, menuId, elId }) {
  const [started, setStarted] = useState(0);

  useEffect(() => {
    setStarted(100);
    setTimeout(
      () => {
        console.log("doneeeee");
      },
      (el.time || el.duration) * 1000,
    );
  }, []);

  return (
    <div key={key} className="flex items-center gap-3 flex-wrap justify-center">
      {<label htmlFor={`menu-${menuId}-number-${elId}`}>{el.label}</label>}
      <div
        id={`menu-${menuId}-number-${elId}`}
        className="appearance-none max-w-full focus:outline-none border-2 bg-black border-green-700 w-1/4 h-5 rounded"
      >
        <div
          className={`w-0 transition-all h-full bg-green-400`}
          style={{
            width: started + "%",
            transition: `width ${el.time || el.duration}s linear`,
          }}
        ></div>
      </div>
    </div>
  );
}
