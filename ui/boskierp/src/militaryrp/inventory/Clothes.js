export default function Clothes({ data, inv, invType }) {
  const images = [
    "inv_helmet",
    "inv_vest",
    "inv_body",
    "inv_szelki",
    "inv_pants",
    "inv_backpack",
    "inv_gloves",
  ];
  const getItemBySlot = (slot) => {
    let items = data?.items?.filter((v, i) => {
      v.idx = i;
      return v.slot === slot;
    });
    if (items) {
      return items[0];
    }
  };
  return (
    <div className="w-full h-full ">
      <div className={"w-full h-full flex flex-col gap-1 items-end"}>
        {Array(10 - 3)
          .fill()
          .map((v, i) => {
            let item = getItemBySlot(i);
            let size = item?.size || [];
            //if (size && data?.slots && size[0])
            //  data.slots = data?.slots - size[0] / 2;
            console.log(data?.slots);
            if (item)
              return (
                <div
                  key={i}
                  data-invtype={invType}
                  data-inv={inv}
                  data-slot={i}
                  data-itemidx={item.idx}
                  data-type={"item"}
                  className={`bg-gray-700 border-gray-400 border w-16 h-16 flex justify-center items-center aspect-square`}
                >
                  <div className="w-full h-full pointer-events-none ">
                    <img
                      draggable={false}
                      className="w-full h-full object-scale-down object-center"
                      alt="WATER"
                      src={`${process.env.PUBLIC_URL}/img/inv/${images[i]}.png`}
                    />
                  </div>
                </div>
              );
            else
              return (
                <div
                  data-invtype={invType}
                  data-inv={inv}
                  data-slot={i}
                  data-type={"slot"}
                  className={`bg-gray-700 border-gray-400 border w-16 h-16 flex justify-center items-center aspect-square`}
                >
                  <div className="w-full h-full pointer-events-none ">
                    <img
                      draggable={false}
                      className="w-full h-full object-scale-down object-center"
                      alt="WATER"
                      src={`${process.env.PUBLIC_URL}/img/inv/${images[i]}.png`}
                    />
                  </div>
                </div>
              );
          })}
      </div>
    </div>
  );
}
