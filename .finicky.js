module.exports = {
  defaultBrowser: "Google Chrome",
  rewrite: [
    {
      match: () => true, // Execute rewrite on all incoming urls to make this example easier to understand
      url({ url }) {
        const removeKeysStartingWith = ["utm_", "uta_"]; // Remove all query parameters beginning with these strings
        const removeKeys = ["fblid", "gclid"]; // Remove all query parameters matching these keys

        const search = url.search
          .split("&")
          .map((parameter) => parameter.split("="))
          .filter(([key]) => !removeKeysStartingWith.some((startingWith) => key.startsWith(startingWith)))
          .filter(([key]) => !removeKeys.some((removeKey) => key === removeKey));

        return {
          ...url,
          search: search.map((parameter) => parameter.join("=")).join("&"),
        };
      },
    }
  ],
  handlers: [
    {
      match: "chime.aws/*",
      url: ({ url }) => ({
        host: "meeting?pin=",
        protocol: "chime",
        pathname: url.pathname.slice(1),
      }),
      browser: "Amazon Chime"
    },
    {
      match: [
        "zoom.us*",
        finicky.matchDomains(/.*\zoom.us/),
        /zoom.us\/j\//,
      ],
      browser: "us.zoom.xos"
  },
  {
      match: ["apple.com*"],
      browser: "Safari"
    },
    {
      match: finicky.matchDomains([
        /.*\.amazon.com/,
        /.*\.a2z.com/,
        /.*\.support.aws.dev/,
        /.*\.awsapps.com/,
        "quip-amazon.com",
        "aws-crm.my.salesforce.com",
        /.*\.asana.com/
      ]),
      browser: "Firefox"
    }
  ]
};
