import React from "react";
import {
    CSSTransition,
    TransitionGroup,
    Transition,
} from "react-transition-group"; // ES6
import Notification from "./Notification";

export default class Notify extends React.Component {
    constructor(props) {
        super(props);

        this.state = {
            Notifies: [] || [
                {
                    id: "nnnnn",
                    type: "info",
                    title: "hello",
                    content: "4444",
                    time: 9000,
                },

                {
                    type: "info",
                    title: "hello",
                    content: "4444",
                    id: "nnnnn4",
                    time: 4444,
                },

                {
                    type: "info",
                    title: "hello",
                    content: "4444",
                    id: "4444",
                    time: 14000,
                },
                {
                    type: "custom",
                    title: "hello",
                    content: "4444",
                    id: "4444dddd",
                    time: 4444,
                    style: {
                        main: "text-black bg-yellow-500 border-yellow-400 ",
                        item: "weapon_assaultrifle",
                        bar: "bg-yellow-400",
                    },
                },
            ],
        };
    }

    onRemove = (id) => {
        this.setState((state) => {
            const Notifies = state.Notifies.filter((v) => v.id !== id);
            return { Notifies };
        });
    };

    render() {
        return (
            <div className="flex justify-end p-1 overflow-hidden opacity-90">
                <div className="w-full h-auto flex flex-col gap-1 transition-all">
                    {this.state.Notifies.map((v, i) => {
                        return (
                            <Notification
                                key={v.id}
                                duration={v.duration || v.time || 4444}
                                data={v}
                                id={i}
                                onRemove={() => this.onRemove(v.id)}
                                startTime={Date.now()}
                            />
                        );
                    })}
                </div>
            </div>
        );
    }
}
