import { useParams, useNavigate } from "react-router-dom";
import sendMessage from "../../../../../Api";
export default function Home() {
  const { number } = useParams();
  const navigate = useNavigate();
  const onSubmit = (e) => {
    e.preventDefault();
    const { name, number } = e.currentTarget.elements;
    sendMessage("phone_manage_contact", {
      name: name.value,
      number: number.value,
    });
    navigate("/");
  };
  return (
    <div className="w-full h-full flex flex-col gap-4 justify-center items-center">
      <form
        onSubmit={onSubmit}
        className="w-full h-full flex items-center justify-center gap-4 flex-col"
      >
        <input
          id="name"
          className="rounded-lg text-black focus:outline-none px-0.5"
          type="text"
          placeholder="Nazwa"
        />
        <input
          id="number"
          className="rounded-lg text-black focus:outline-none px-0.5"
          type="text"
          placeholder="Numer"
          defaultValue={number}
        />
        <button className="rounded-lg p-0.5 border" type="submit">
          Zapisz
        </button>
      </form>
    </div>
  );
}
