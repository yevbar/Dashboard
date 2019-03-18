// State declaration
type state =
    | Loading
    | Error
    | Success

// Action declaration
type action =
    | UserFetch
    | UserFetched(string)
    | UserFailedToFetch

let component = ReasonReact.reducerComponent("App")

let loadingMessage = "Currently loading!";
let errorMessage = "An error has occurred!";
let successMessage = "You've successfully made the API call!"

type user = {
    userId: int,
    userName: string
};

module Decode = {
    let name = json: string =>
        Json.Decode.(
            json |> field("userName", string)
        );
};

let randomList = ["This", "is", "a", "list"];

let randomDivs = List.map((item) =>
    <div>(ReasonReact.string(item))</div>,
    randomList);

let make = (_children) => {
    ...component,

    initialState: _state => Loading,

    reducer: (action, state) =>
        switch (action) {
            | UserFetch => ReasonReact.UpdateWithSideEffects(
                Loading,
                (
                    self => Js.Promise.(
                        Fetch.fetch("/bob")
                        |> then_(Fetch.Response.json)
                        |> then_(json =>
                            json
                            |> Decode.name
                            |> (name => self.send(UserFetched(name)))
                            |> resolve
                        )
                        |> catch(_err =>
                            Js.Promise.resolve(self.send(UserFailedToFetch))
                        ) |> ignore
                    )       
                )
            )
            | UserFetched(user) => {
                Js.log(user);
                ReasonReact.Update(Success);
            }
            | UserFailedToFetch => ReasonReact.Update(Error)
        },
    
    didMount: self => self.send(UserFetch),

    render: _self =>
        <div>
            (
                ReasonReact.array(Array.of_list(randomDivs))
            )
        </div>
    /*
        switch(self.state) {
            | Error => <div>(ReasonReact.string(errorMessage))</div>
            | Loading => <div>(ReasonReact.string(loadingMessage))</div>
            | Success => <div>(ReasonReact.string(successMessage))</div>
        }
        */
};