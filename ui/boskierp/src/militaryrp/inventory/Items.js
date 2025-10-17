import { useEffect, useState } from "react";

export default function Items({ style, data, inv, invType }) {
  const [occupiedSlots, setOccupiedSlots] = useState([]);
  const [slots, setSlots] = useState(0);
  const getItemBySlot = (slot) => {
    let items = data?.items?.filter((v, i) => {
      v.idx = i;
      return v.slot === slot;
    });
    if (items) {
      return items[0];
    }
  };

  const getSlotsCount = () => {
    let [rows, columns] = data?.size;
    let slots = data?.size[0] * data?.size[1];
    let itemSizes = data?.items?.filter((v) => v.size && v.size[0]);

    const occupiedSlotsItem = [];
    itemSizes.forEach((v, i) => {
      let [width, height] = v.size;
      if (!width) width = 1;
      if (!height) height = 1;

      for (let row = v.slot; row < v.slot + width; row++) {
        occupiedSlotsItem.push(row);
        let starterColumn = row;
        for (let col = 1; col < height; col++) {
          starterColumn = starterColumn + rows;

          occupiedSlotsItem.push(starterColumn);
        }
      }
      //slots -= v.size[0] - 1;
      //for (let j = v.slot; j >= v.size[1]; j++) {
      //  occupiedSlots.push(j);
      //  if (!v.size[1]) v.size[1] = 1;
      //  for (let d = j; d >= v.size[1]; d++) {
      //    occupiedSlots.push(d);
      //  }
      //}
      //console.log(occupiedSlots);
    });
    setOccupiedSlots(occupiedSlotsItem);
    console.log(occupiedSlotsItem);
    return slots;
  };

  useEffect(() => {
    setSlots(getSlotsCount());
    //console.log("dddd", data.items.length, slots, data.slots);
  }, [data?.items?.length]);

  const getOccupiedSlots = (slot, size, columns) => {
    let [width, height] = size;
    if (!width) width = 1;
    if (!height) height = 1;
    const occupiedSlots = [];

    for (let row = 0; row < height; row++) {
      for (let col = 0; col < width; col++) {
        occupiedSlots.push(slot + col - row * columns);
      }
    }

    return occupiedSlots;
  };

  return (
    <div className="flex flex-col gap-1">
      <div className="h-16 bg-slate-800 px-1.5">
        <div className="w-full h-full flex gap-1">
          <img
            className="w-16 object-scale-down object-center"
            alt="WATER"
            src={`${process.env.PUBLIC_URL}/img/inv/weapon_assaultrifle.png`}
          />
          <div className="flex flex-col gap-1 text-white w-full justify-between flex-wrap">
            <div>{data.label}</div>
            <div className="h-1.5 border border-gray-400 bg-orange-400 w-16"></div>
            <div className="text-sm text-right self-end">3.44kg</div>
          </div>
        </div>
      </div>
      <div
        className={`grid grid-cols-${data.size[0]} grid-rows-${data.size[1]}  gap-1 box-border`}
      >
        {Array.from({ length: slots }, (e, key) => key)
          //.filter((v, i) => !occupiedSlots.find((m, d) => m === v))
          .map((v, d) => {
            let i = v;
            i++;
            let item = getItemBySlot(i);
            let size = item?.size || [];
            //if (size && data?.slots && size[0])
            //  data.slots = data?.slots - size[0] / 2;
            //
            //
            //console.log(data?.slots);
            if (!item && occupiedSlots.some((d, m) => d === i)) return null;
            if (item) {
              return (
                <div
                  key={i}
                  data-invtype={invType}
                  data-inv={inv}
                  data-slot={i}
                  data-itemidx={item.idx}
                  data-type={"item"}
                  data-iname={item.name}
                  style={{
                    gridColumn: `span ${size[0]} / span ${size[0]}`,
                    gridRow: `span ${size[1]} / span ${size[1]}`,
                  }}
                  className={`bg-gray-700 border-gray-400 border flex justify-center items-center self-start box-border ${size[0] ? `aspect-[4/1] w-full h-full` : "aspect-square"} `}
                >
                  <div className="w-full h-full pointer-events-none ">
                    <img
                      draggable={false}
                      className="w-full h-full object-scale-down object-center"
                      alt="WATER"
                      src={`${process.env.PUBLIC_URL}/img/inv/weapon_assaultrifle.png`}
                    />
                  </div>
                </div>
              );
            } else
              return (
                <div
                  data-invtype={invType}
                  data-inv={inv}
                  data-slot={i}
                  data-type={"slot"}
                  className={`bg-gray-700 border-gray-400 border aspect-square flex justify-center items-center self-start `}
                >
                  {i}
                </div>
              );
          })}
      </div>
    </div>
  );
}
