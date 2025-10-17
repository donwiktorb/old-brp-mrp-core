function Container({ props, child }) {
  return <div className={`${props.style}`}>{child}</div>;
}

function Input() {
    switch (el.type) {
      case "select": {
        return (
          <div className="flex items-center gap-3 flex-wrap justify-center">
            <label className="italic" for={`menu-${menuId}-select-${elId}`}>
              {el.label}
            </label>
            <select
              name={`menu-${menuId}-select-${elId}`}
              className="appearance-none px-1 focus:outline-none bg-black rounded border-green-700 border"
              type="text"
              value={el.value}
            >
              {el.options.map((option, optionId) => {
                return (
                  <option
                    value={optionId}
                    className="appearance-none bg-green-400 "
                  >
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
          <div className={`flex gap-1 justify-center items-center`}>
            <input
              className="appearance-none bg-green-900 border-green-900 checked:bg-green-500 border-2 w-5 h-5 rounded"
              type="color"
            />
            <label>{el.label}</label>
          </div>
        );
      }
      case "textarea": {
        return (
          <div className="flex justify-center items-center ">
            <textarea
              placeholder={el.label}
              className="bg-black max-w-full rounded border-green-700 border focus:outline-none p-0.5"
            ></textarea>
          </div>
        );
      }
      case "date": {
        return (
          <div className="flex items-center gap-3 flex-wrap justify-center">
            {<label for={`menu-${menuId}-number-${elId}`}>{el.label}</label>}
            <input
              id={`menu-${menuId}-number-${elId}`}
              type="date"
              class="border-2 max-w-full bg-black border-green-700 checked:bg-green-400 rounded focus:outline-none"
            />
          </div>
        );
      }
      case "radio": {
        return (
          <div className="flex items-center gap-3 flex-wrap justify-center">
            {<label for={`menu-${menuId}-number-${elId}`}>{el.label}</label>}
            <input
              id={`menu-${menuId}-number-${elId}`}
              type="radio"
              class="appearance-none border-2 w-5 h-5 bg-black border-green-700 checked:bg-green-400 rounded-full"
            />
          </div>
        );
      }
      case "number": {
        return (
          <div className="flex items-center gap-3 flex-wrap justify-center">
            {<label for={`menu-${menuId}-number-${elId}`}>{el.label}</label>}
            <input
              id={`menu-${menuId}-number-${elId}`}
              type="number"
              class="appearance-none max-w-full focus:outline-none border-2 bg-black border-green-700 checked:bg-green-400 w-14 h-5 rounded"
            />
          </div>
        );
      }
      case "range-number": {
        return (
          <div className="flex items-center gap-3 flex-wrap justify-center">
            {<div className="italic">{el.label}</div>}
            {
              <label for={`menu-${menuId}-checkbox-${elId}`}>
                {el.fromLabel}
              </label>
            }
            <input
              id={`menu-${menuId}-checkbox-${elId}`}
              type="number"
              class="appearance-none focus:outline-none border-2 bg-black border-green-700 checked:bg-green-400 w-14 h-5 rounded"
            />
            {
              <label for={`menu-${menuId}-checkbox-${elId}`}>
                {el.toLabel}
              </label>
            }
            <input
              id={`menu-${menuId}-checkbox-${elId}`}
              type="number"
              class="appearance-none focus:outline-none border-2 bg-black border-green-700 checked:bg-green-400 w-14 h-5 rounded"
            />
          </div>
        );
      }
      case "table": {
        return (
          <div
            className={`${el.style?.imgBox ?? parentElement?.style?.imgBox} `}
          >
            <table
              className={`${el.style?.table ?? parentElement?.style?.table} table-fixed w-full`}
            >
              <thead
                className={`${el.style?.thead ?? parentElement?.style?.thead}`}
              >
                <tr>
                  {el.rows.map((row, rowId) => {
                    return <th>{row.label}</th>;
                  })}
                </tr>
              </thead>
              <tbody
                className={`${el.style?.tbody ?? parentElement?.style?.tbody}`}
              >
                {el.elements.map((item, itemId) => {
                  return (
                    <tr className="">
                      {item.rows.map((row, rowId) => {
                        return (
                          <td>{this.getHtmlElement(row, rowId, menuId, el)}</td>
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
          <div className="flex items-center gap-3">
            {el.fromRight && (
              <label for={`menu-${menuId}-checkbox-${elId}`}>{el.label}</label>
            )}
            <input
              id={`menu-${menuId}-checkbox-${elId}`}
              defaultChecked={el.value}
              type="checkbox"
              class="appearance-none transtion-all hover:bg-green-900 border-2 bg-black border-green-700 checked:bg-green-400 w-5 h-5 rounded"
            />
            {!el.fromRight && (
              <label for={`menu-${menuId}-checkbox-${elId}`}>{el.label}</label>
            )}
          </div>
        );
      }
      case "search": {
        return (
          <div className="flex justify-center items-center">
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
          <div className={el.style?.imgBox ?? parentElement?.style?.imgBox}>
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
          <div className="flex justify-center items-center ">
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
          <div className={style.box}>
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
                      stroke="#000000"
                      stroke-width="1.5"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                    />
                  </svg>
                </button>
                <div
                  className="self-center justify-self-center w-full"
                  dangerouslySetInnerHTML={{ __html: el.title }}
                ></div>
              </div>
            )}
            {el.elements && (
              <div className={style.elements}>
                {(el.filteredElements ?? el.elements).map(
                  (sectionElem, sectionElemId) => {
                    return this.getHtmlElement(
                      sectionElem,
                      sectionElemId,
                      menuId,
                      el,
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
                class={`flex ${el.selected && "bg-green-900"} ${el.style && el.style} `}
                dangerouslySetInnerHTML={{ __html: el.label }}
              ></div>
            )}
            {(el.subLabels ?? parentElement.subLabels) && (
              <div class={`w-full `}>
                <ul className="flex justify-between flex-wrap break-words list-disc ">
                  {(el.subLabels ?? parentElement.subLabels).map(
                    (label, labelId) => {
                      return <li className={label.style}>{label.label}</li>;
                    },
                  )}
                </ul>
              </div>
            )}
            {(el.actions ?? parentElement.actions) && (
              <div class={`flex flex-wrap `}>
                <div
                  className={`${el.style?.actions ?? parentElement.style?.actions} flex flex-wrap justify-around w-full gap-4`}
                >
                  {(el.actions ?? parentElement.actions).map(
                    (action, actionId) => {
                      return this.getHtmlElement(action, actionId, menuId, el);
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
            type={el.type}
            className={`${el.style?.button ?? parentElement?.style?.button} max-w-full`}
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
                class={`w-full ${el.selected && "bg-green-900"} ${el.style && el.style} `}
                dangerouslySetInnerHTML={{ __html: el.label }}
              ></div>
            )}
            {(el.subLabels ?? parentElement.subLabels) && (
              <div class={`w-full max-w-full`}>
                <ul className="flex justify-between flex-wrap break-words list-disc max-w-full">
                  {(el.subLabels ?? parentElement.subLabels).map(
                    (label, labelId) => {
                      return <li className={label.style}>{label.label}</li>;
                    },
                  )}
                </ul>
              </div>
            )}
            {(el.actions ?? parentElement.actions) && (
              <div class={`w-full max-w-full flex flex-wrap`}>
                <div
                  className={`${el.style?.actions} flex flex-wrap max-w-full`}
                >
                  {(el.actions ?? parentElement.actions).map(
                    (action, actionId) => {
                      return this.getHtmlElement(action, actionId, menuId, el);
                    },
                  )}
                </div>
              </div>
            )}
          </button>
        );
      }
}

function Elements() {

}

function Element() {
  return (
    <Container>
      <Images>
        <Badges />
      </Images>
      <Labels />
      <SubLabels />
      <Actions />
    </Container>
  );
}

function Section() {
  return (
    <Container>
      <Title />
      <Elements />
    </Container>
  );
}
