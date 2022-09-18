module.exports = {
  defaultBrowser: "Google Chrome",
  options: {
    hideIcon: true, 
  },
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
    },
    {
      // Opens Paragon links in Command Center
      match: 'https://paragon-na.amazon.com/hz/view-case?caseId=*',
      url: ({ url }) => {
        const caseId = url.search
          .match(/caseId=([\d]+)/)
        return {
          ...url,
          host: "command-center.support.aws.a2z.com",
          pathname: '/case-console',
          search: '',
          hash: '/cases/' + caseId.slice(1)
        }
      }
    },
    {
      match: ["https://*console.aws.amazon.com/support/home?*/case/*"],
      // match: ({ url, opener }) =>
      //   url.match("https://*console.aws.amazon.com/support/home?*/case/*") &&
      //   opener.bundleId === "com.tinyspeck.slackmacgap" ||
      //   opener.bundleId.endsWith('Telegram'),
      url: ({ url }) => {
        const caseId = url.search
          .match(/displayId=([\d]+)/) ||
          url.hash.match(/displayId=([\d]+)/)
        return {
          ...url,
          host: "command-center.support.aws.a2z.com",
          pathname: '/case-console',
          search: '',
          hash: '/cases/' + caseId.slice(1)
        }
      }
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
        finicky.matchDomains(/.*zoom.us/),
        /zoom.us\/j\//,
      ],
      browser: "us.zoom.xos"
    },
    {
      match: [
        "apple.com*",
        "aws.amazon.com/blogs*",
        "aws.amazon.com/about-aws/whats-new/*"
      ],
      browser: "Safari"
    },
    {
      match: finicky.matchDomains([
        /.*\.workshops.aws$/,
        /.*\.amazon.(com|dev)/,
        /.*\.a2z.com/,
        /.*\.support.aws.dev/,
        /.*\.aws-border.com/,
        /.*\.awstrack.me/,
        /.*\.awsapps.com/,
        /.*\.immersionday\.com/,
        "quip-amazon.com",
        "aws-crm.my.salesforce.com",
        /.*\.asana.com/
      ]),
      browser: "Firefox"
    },
    {
      match: [
        finicky.matchDomains([
          /.*\.aws$/,
          "docs.aws.amazon.com",
          "youtube.com",
          "youtu.be",
          "vimeo.com",
          /.*\.ua$/,
        ]),
      ],
      browser: "Safari"
    }
  ]
};
