import React, { useState, useEffect } from "react";
import "./spins.css";

const symbols = ["🍒", "🍋", "🍊", "🍉", "⭐", "💎"];

const SlotMachine = () => {
  const [reels, setReels] = useState([0, 0, 0]); // Final positions of reels
  const [spinning, setSpinning] = useState(false);

  const spinReels = () => {
    setSpinning(true);

    // Simulate random stops for each reel
    const newReels = reels.map(() =>
      Math.floor(Math.random() * symbols.length),
    );

    setTimeout(() => {
      setReels(newReels); // Set final positions
      setSpinning(false);
      checkWin(newReels);
    }, 2000); // Spin duration
  };

  const checkWin = (newReels) => {
    const [first, second, third] = newReels;
    if (first === second && second === third) {
      //alert("🎉 You Win!");
    } else {
      //alert("😢 Try Again!");
    }
  };

  if (true) return <></>;
  return (
    <div className="slot-machine">
      <div className="reels">
        {reels.map((reel, index) => (
          <div key={index} className="reel">
            <div
              className={`symbols-container ${spinning ? "spinning" : ""}`}
              style={{
                transform: `translateY(-${reels[index] * 100}%)`,
                transition: spinning ? "none" : "transform 0.5s ease-out",
              }}
            >
              {symbols.concat(symbols).map((symbol, i) => (
                <div key={i} className="symbol">
                  {symbol}
                </div>
              ))}
            </div>
          </div>
        ))}
      </div>
      <button onClick={spinReels} disabled={spinning}>
        {spinning ? "Spinning..." : "Spin"}
      </button>
    </div>
  );
};

export default SlotMachine;
