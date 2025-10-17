export default function Clothes({ data, inv, invType }) {
  const images = [];
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
      <div className={"w-full h-full grid grid-cols-5 gap-1 items-end"}>
        {Array(9)
          .fill()
          .map((v, i) => {
            let item = getItemBySlot(i);

            if (item)
              return (
                <div
                  key={i}
                  data-invtype={invType}
                  data-inv={inv}
                  data-slot={i}
                  data-itemidx={item.idx}
                  data-type={"item"}
                  className={`bg-gray-700 border-gray-400 border w-16 h-16 flex justify-center items-center aspect-square ${(i == 0) & "col-span-2"}`}
                >
                  <div className="w-full h-full pointer-events-none ">
                    <img
                      draggable={false}
                      className="w-full h-full object-scale-down object-center"
                      alt="WATER"
                      src={`${process.env.PUBLIC_URL}/img/inv/${images[i] || images[0]}.png`}
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
                  className={`bg-gray-700 border-gray-400 border w-full h-20 flex justify-center items-center self-start ${i == 0 && "col-span-2"}`}
                >
                  <div className="w-full h-full pointer-events-none ">
                    <img
                      draggable={false}
                      className="w-full h-full object-scale-down object-center grayscale opacity-70"
                      alt="WATER"
                      src={`${process.env.PUBLIC_URL}/img/inv/${images[i] || images[0]}.png`}
                    />
                  </div>
                </div>
              );
          })}
      </div>
    </div>
  );
}
