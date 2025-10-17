import React from "react";
import { useState, useEffect } from "react";
import { CSSTransition } from "react-transition-group";
export default function Notification({
  onRemove,
  duration,
  data,
  id,
  startTime,
}) {
  const [progress, setProgress] = useState(0);
  const [progress4, setProgress4] = useState(0);
  const [removed, setRemoved] = useState(false);
  const [formats, setFormats] = useState([
    {
      in: "<k>",
      rep: '<kbd class="p-0.5 border-2 rounded-sm shadow-md shadow-white text-black bg-white">',

      outRep: "</kbd>",
      out: "</k>",
    },
  ]);

  useEffect(() => {
    setProgress4(100);
    console.time(`${duration}`);
  }, [duration, onRemove]);

  const formatter = (html) => {};

  const getTheme = (v, k) => {
    switch (v.type) {
      case "info": {
        return (
          <div
            key={`notify-${data.id}`}
            className={` bg-blue-900 border-t-4 border-blue-500 rounded-b text-blue-100 px-4 py-3 shadow-md self-end w-fit transition-all ${removed ? "animate-toRightOut" : "animate-toLeft"}`}
            style={{
              transform: `translateX(${removed ? 150 : 0}%)`,
              transition: `transform 100ms linear`,
            }}
            role="alert"
          >
            <div className="flex">
              <div className="py-1">
                <svg
                  className="fill-current h-6 w-6 text-blue-500 mr-4"
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 20 20"
                >
                  <path d="M2.93 17.07A10 10 0 1 1 17.07 2.93 10 10 0 0 1 2.93 17.07zm12.73-1.41A8 8 0 1 0 4.34 4.34a8 8 0 0 0 11.32 11.32zM9 11V9h2v6H9v-4zm0-6h2v2H9V5z" />
                </svg>
              </div>
              <div>
                <p
                  className="font-bold"
                  dangerouslySetInnerHTML={{ __html: data.title }}
                ></p>
                <p
                  className="text-sm"
                  dangerouslySetInnerHTML={{ __html: data.content }}
                ></p>
              </div>
            </div>
            <div className="w-full mt-2 bg-gray-700 rounded-full h-0.5 dark:bg-gray-700">
              <div
                className="bg-blue-600 h-0.5 rounded-full "
                style={{
                  width: progress4 + "%",
                  transition: `width ${duration}ms linear`,
                }}
              ></div>
            </div>
          </div>
        );
      }

      case "warn": {
        return (
          <div
            key={`notify-${data.id}`}
            className={` bg-red-900 border-t-4 border-red-500 rounded-b text-red-100 px-4 py-3 shadow-md self-end w-fit `}
            style={{
              transform: `translateX(${removed ? 150 : 0}%)`,
              transition: `transform 100ms linear`,
            }}
            role="alert"
          >
            <div className="flex">
              <div className="py-1">
                <svg
                  className="fill-current h-6 w-6 text-red-500 mr-4"
                  viewBox="0 0 24 24"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path d="M12.866 3l9.526 16.5a1 1 0 0 1-.866 1.5H2.474a1 1 0 0 1-.866-1.5L11.134 3a1 1 0 0 1 1.732 0zm-8.66 16h15.588L12 5.5 4.206 19zM11 16h2v2h-2v-2zm0-7h2v5h-2V9z" />
                </svg>
              </div>
              <div>
                <p
                  className="font-bold"
                  dangerouslySetInnerHTML={{ __html: v.title }}
                ></p>
                <p
                  className="text-sm"
                  dangerouslySetInnerHTML={{ __html: v.content }}
                ></p>
              </div>
            </div>
            <div className="w-full mt-2 bg-gray-700 rounded-full h-0.5 dark:bg-gray-700">
              <div
                className="bg-red-600 h-0.5 rounded-full transition-all "
                style={{
                  width: progress4 + "%",
                  transition: `width ${duration}ms linear`,
                }}
              ></div>
            </div>
          </div>
        );
      }

      case "success": {
        return (
          <div
            key={`notify-${data.id}`}
            className={` bg-green-900 border-t-4 border-green-500 rounded-b text-green-100 px-4 py-3 shadow-md self-end w-fit transition-all`}
            role="alert"
            style={{
              transform: `translateX(${removed ? 150 : 0}%)`,
              transition: `transform 100ms linear`,
            }}
          >
            <div className="flex">
              <div className="py-1">
                <svg
                  className="fill-current h-6 w-6 text-green-500 mr-4"
                  viewBox="0 0 24 24"
                  xmlns="http://www.w3.org/2000/svg"
                >
                  <path
                    d="M10.2426 16.3137L6 12.071L7.41421 10.6568L10.2426 13.4853L15.8995 7.8284L17.3137 9.24262L10.2426 16.3137Z"
                    fill="currentColor"
                  />
                  <path
                    fillRule="evenodd"
                    clipRule="evenodd"
                    d="M1 12C1 5.92487 5.92487 1 12 1C18.0751 1 23 5.92487 23 12C23 18.0751 18.0751 23 12 23C5.92487 23 1 18.0751 1 12ZM12 21C7.02944 21 3 16.9706 3 12C3 7.02944 7.02944 3 12 3C16.9706 3 21 7.02944 21 12C21 16.9706 16.9706 21 12 21Z"
                    fill="currentColor"
                  />
                </svg>
              </div>
              <div>
                <p
                  className="font-bold"
                  dangerouslySetInnerHTML={{ __html: v.title }}
                ></p>
                <p
                  className="text-sm"
                  dangerouslySetInnerHTML={{ __html: v.content }}
                ></p>
              </div>
            </div>
            <div className="w-full mt-2 bg-gray-700 rounded-full h-0.5 dark:bg-gray-700">
              <div
                className="bg-green-600 h-0.5 rounded-full transition-all "
                style={{
                  width: progress4 + "%",
                  transition: `width ${duration}ms linear`,
                }}
              ></div>
            </div>
          </div>
        );
      }

      case "custom": {
        return (
          <div
            key={`notify-${data.id}`}
            className={` border-t-4 rounded-b px-4 py-3 shadow-md self-end w-fit transition-all animate-toLeft ${v.style?.main}`}
            role="alert"
            style={{
              transform: `translateX(${removed ? 150 : 0}%)`,
              transition: `transform 100ms linear`,
            }}
          >
            <div className="flex">
              <div className="py-1">
                {v.style?.item && (
                  <img
                    alt={v.style?.item}
                    src={`${process.env.PUBLIC_URL}/img/inv/${v.style?.item}.png`}
                    className="fill-current h-6 w-6 text-current mr-4 object-center object-scale-down"
                  />
                )}
                {v.style?.img && (
                  <img
                    alt={v.style?.img}
                    src={v.style?.img}
                    className="fill-current h-6 w-6 text-green-500 mr-4 object-center object-scale-down"
                  />
                )}
                {v.style?.svg && (
                  <div
                    className="fill-current h-6 w-6 text-green-500 mr-4 object-center object-scale-down"
                    dangerouslySetInnerHTML={{ __html: v.style.svg }}
                  ></div>
                )}
                {!v.style?.item && !v.style?.img && (
                  <svg
                    className="fill-current h-6 w-6 text-green-500 mr-4"
                    viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      d="M10.2426 16.3137L6 12.071L7.41421 10.6568L10.2426 13.4853L15.8995 7.8284L17.3137 9.24262L10.2426 16.3137Z"
                      fill="currentColor"
                    />
                    <path
                      fillRule="evenodd"
                      clipRule="evenodd"
                      d="M1 12C1 5.92487 5.92487 1 12 1C18.0751 1 23 5.92487 23 12C23 18.0751 18.0751 23 12 23C5.92487 23 1 18.0751 1 12ZM12 21C7.02944 21 3 16.9706 3 12C3 7.02944 7.02944 3 12 3C16.9706 3 21 7.02944 21 12C21 16.9706 16.9706 21 12 21Z"
                      fill="currentColor"
                    />
                  </svg>
                )}
              </div>
              <div>
                <p
                  className="font-bold"
                  dangerouslySetInnerHTML={{ __html: v.title }}
                ></p>
                <p
                  className="text-sm"
                  dangerouslySetInnerHTML={{ __html: v.content }}
                ></p>
              </div>
            </div>
            <div className="w-full mt-2 bg-gray-700 rounded-full h-0.5 ">
              <div
                className={`h-0.5 rounded-full transition-all ${v.style?.bar}`}
                style={{
                  width: progress4 + "%",
                  transition: `width ${duration}ms linear`,
                }}
              ></div>
            </div>
          </div>
        );
      }

      default: {
        break;
      }
    }
  };

  return getTheme(data, id);
}
