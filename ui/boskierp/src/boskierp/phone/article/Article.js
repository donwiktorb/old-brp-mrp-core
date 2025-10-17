import React from "react";
import { Navigate, Routes, Route } from "react-router-dom";
import Home from "./routes/home/Home";
import Phone from "./routes/phone/Phone";
import Message from "./routes/message/Message";
import Call from "./routes/call/Call";
import Messages from "./routes/messages/Messages";
import Contacts from "./routes/phone/routes/contacts/Contacts";
import Apps from "./routes/apps/Apps";
import Calls from "./routes/phone/routes/calls/Calls";

import Crime from "./routes/apps/crime/Crime";
import Edit from "./routes/edit/Edit";
import Store from "./routes/apps/store/Store";
import Gallery from "./routes/apps/gallery/Gallery";
import Twitter from "./routes/apps/twitter/Twitter";
export default class Article extends React.Component {
  constructor(props) {
    super(props);
    this.state = props.state;
    // // // // this.routes = [
    // // // // ]
  }

  static getDerivedStateFromProps(nextProps, state) {
    if (nextProps.state !== state && nextProps) {
      return nextProps.state ? nextProps.state : [];
    } else return null;
  }

  render() {
    return (
      <div className="w-full h-full overflow-auto">
        <Routes>
          <Route
            path={"/twitter"}
            element={<Twitter messages={this.state.chats.twitter} />}
          />
          <Route
            path={"/photos"}
            element={<Gallery photos={this.state.gallery} />}
          />{" "}
          <Route
            path={"/store"}
            element={<Store apps={this.state.storeApps} />}
          />{" "}
          <Route
            path={"/crime"}
            element={
              <Crime
                data={this.state.crime}
                messages={this.state.chats.darkweb}
              />
            }
          />
          <Route path={"/apps"} element={<Apps />} />
          <Route
            path={"/call/:number/:caller"}
            element={
              <Call
                manager={this.state.callStateManager}
                callFn={(data) => this.props.callFn(data)}
              />
            }
          />
          <Route
            path={"/call/:number/"}
            element={
              <Call
                manager={this.state.callStateManager}
                callFn={this.props.callFn}
              />
            }
          />
          <Route
            path={"/message/:number/"}
            element={<Message messages={this.state.messages} />}
          />
          <Route
            path={"/messages"}
            element={<Messages lastMessages={this.state.lastMessages} />}
          />
          <Route path={"/edit"} element={<Edit />} />
          <Route path={"/edit/:number"} element={<Edit />} />
          <Route path={"/phone"} element={<Phone />}>
            <Route
              path={""}
              element={<Calls calls={this.state.calls} />}
            ></Route>
            <Route
              path={"calls"}
              element={<Calls calls={this.state.calls} />}
            ></Route>
            <Route
              path={"contacts"}
              element={<Contacts contacts={this.state.contacts} />}
            ></Route>
          </Route>
          <Route path={""} element={<Home state={this.state} />} />
          <Route path={"/"} element={<Home state={this.state} />} />
        </Routes>
      </div>
    );
  }
}

