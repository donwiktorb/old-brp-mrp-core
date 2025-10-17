const type = "mysql";

var mysql;

// for compatibility with older esx version (originally that was written for esx) its similar to this https://github.com/brouznouf/fivem-mysql-async/blob/master/src/entry/server.ts
class Mysql {
    constructor() {
        this.isReady = false;
        // this.log = (logType, str) => logType === 'error' ? console.log(`\x1b[33m[dwb_mysql:error] -> ${str}`) : console.log(`\x1b[36m[dwb_mysq:log] -> ${str}`)
        this.log = (e, q, p) =>
            console.log(
                `\x1b[33m[dwb_mysql:error] -> ${e} -> ${q || "not found"} -> ${p || "not found"}`,
            );
        this.export = global.exports;
        this.config = {
            host: "YOURS",

            user: "YOURS",
            password: "YOURS",
            database: "dwb",
        };

        this.retries = 0;

        if (!this.config)
            return this.log(
                "error",
                `Config in core -> base -> config -> server -> config.json not found`,
            );

        this.mysql = require("mysql2");
        this.pool = this.mysql.createPool(this.config);

        this.pool.query("SELECT VERSION()", (e, r) => {
            if (e) {
                this.log(e, "connecting");
                this.log("log", `Retrying database connection...`);
                this.retry();
            } else {
                this.log("log", `Connection with database established!`);
                this.isReady = true;
                this.retries = 0;
            }
        });

        this.invoke = (cb, args) => {
            if (cb) setImmediate(() => cb(args));
        };

        this.export("mysql_execute", (q, p, cb) => {
            const ir = global.GetInvokingResource();
            this.execute(q, p, ir)
                .then((res) => {
                    this.invoke(cb, res);
                })
                .catch((e) => this.log(e, q, p));
        });

        this.export("mysql_fetch", (q, p, cb) => {
            const ir = global.GetInvokingResource();
            this.execute(q, p, ir)
                .then((res) => {
                    this.invoke(cb, res?.[0]);
                })
                .catch((e) => this.log(e, q, p));
        });

        this.export("mysql_fetch_all", (q, p, cb) => {
            const ir = global.GetInvokingResource();
            this.execute(q, p, ir)
                .then((res) => {
                    this.invoke(cb, res);
                })
                .catch((e) => this.log(e, q, p));
        });

        this.export("mysql_fetch_scalar", (q, p, cb) => {
            const ir = global.GetInvokingResource();
            this.execute(q, p, ir)
                .then((res) => {
                    this.invoke(cb, res && res[0] ? Object.values(res[0])[0] : null);
                })
                .catch((e) => this.log(e, q, p));
        });

        this.export("mysql_insert", (q, p, cb) => {
            const ir = global.GetInvokingResource();
            this.execute(q, p, ir)
                .then((res) => {
                    // // this.log(q,p + " "+res.insertId)
                    this.invoke(cb, res ? res.insertId : 0);
                })
                .catch((e) => this.log(e, q, p));
        });

        this.export("is_ready", () => this.isReady);
    }

    retry() {
        this.pool = this.mysql.createPool(this.config);

        this.pool.query("SELECT VERSION()", (e, r) => {
            if (e) {
                this.log(e);
                this.retries += 1;
                this.log("log", `Retrying database connection... ${this.retries}`);
                if (this.retries < 10)
                    setTimeout(() => {
                        this.retry();
                    }, 2000);
                else
                    this.log(
                        "error",
                        `Couldn't connect to database after ${this.retries} retries`,
                    );
            } else {
                this.log("log", `Connection with database established!`);
                this.retries = 0;
                this.isReady = true;
            }
        });
    }

    execute(q, p, ir) {
        console.log(q, p, ir);
        return new Promise((res, rej) => {
            this.pool.query(q, p, (e, result) => {
                if (e) rej(e);
                res(result);
            });
        }).catch((e) => this.log(e, q, p));
    }
}

const createMysqlConnection = () => {
    if (!mysql) mysql = new Mysql();
    else mysql.retry();
};

createMysqlConnection();
