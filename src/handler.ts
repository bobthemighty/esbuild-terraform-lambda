import { EventBridgeHandler } from "aws-lambda";

// type representing the empty object {}
type Empty = Record<string, never>;

const formatter = new Intl.DateTimeFormat("default", {
  hour: 'numeric', minute: 'numeric',
  timeZoneName: 'short'
})

const handler: EventBridgeHandler<
  "Scheduled Event",
  Empty,
  void
> = async () => {
    console.log(`Hello world. The time is now ${formatter.format(new Date())}`)
};

export { handler };
