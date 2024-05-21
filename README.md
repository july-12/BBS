<p align="center">
  <img src="https://github.com/july-12/BBS/blob/main/app/assets/images/logo.svg" width="300">
  <p align="center">Open source BBS website. inspiration from <a href="https://ruby-china.org">Ruby China</a></p>
</p>

## Intro

这是一个开源社区网站，基于 rails 7.1 版本构建，采用 docker 部署，页面风格借鉴ruby-china。

## Feature

-  登录/注册
-  发帖子
-  回复评论
-  富文本编辑
-  全文检索
-  点赞/收藏/订阅
-  相互关注 
-  上传头像
-  docker部署

## Stack

#### 后端

- [Rails 7.1](https://guides.rubyonrails.org/)
- Postgresql
- Redis
- Turbo(Hotwire)
- [Solr(全文检索)](https://solr.apache.org/)
- [ahoy(埋点)](https://github.com/ankane/ahoy)

#### 前端

- [Stimulus](https://stimulus.hotwired.dev/)
- [Tailwindcss](https://tailwindcss.com/)
- React 18
- [Lexical(富文本)](https://lexical.dev/)

## Usage

1. bundle install (国内可参考此[方法](https://ruby-china.org/topics/26314)加速安装速度)
2. pnpm install (node >= 20)
2. echo "RAILS_ENV=development" >> .env
3. 启动solr后台服务，以支持全文检索 ```docker compose -f compose-solr-dev.yaml up --build -d```
4. rails db:prepare
5. 启动Rails： ```./bin/dev```

访问 http://localhost:3000

## Deploy

1. 克隆项目到服务器 
2. 设置项目的COS配置信息（可选）

    在本地通过如下命令打开rails credentials设置storage active需要读取的COS services信息

    - ```EDITOR="code --wait" rails credentials:edit -e production```

    首次输入此命名前，请先执行删除config/credentials操作

    - 本项目以腾讯云的COS为例, 编辑如下信息

        ```conf
        tencent:
        endpoint: endpoint # eg: https://cos.ap-shanghai.myqcloud.com
        access_key_id: "your_access_key"
        secret_access_key: "your_secret"
        bucket: bucket # eg: "bbs-1324771650"
        region: your_server_region # eg: "ap-shanghai"
        ```

    #### 如果项目用不到COS，则在**config/environments/production.rb**中关掉

        ```ruby
        config.active_storage.service = :local # :tencent
        ```

2. 准备ssl证书

    - 把证书拷贝至服务器 ```/path/to/project/certs``` 目录下
    - 并把证书对应的crt和key文件分别重命名成**cert.crt**, **cert.key**

3. 设置环境变量 ```.env```
    ```conf
    RAILS_ENV=production
    POSTGRES_DB=your_database
    POSTGRES_USER=rails
    POSTGRES_PASSWORD=your_password
    DATABASE_URL=postgres://rails:your_password@db:5432/your_database
    RAILS_MASTER_KEY=key # 把config/credentials/production.key值设置给该变量
    SERVER_NAME=server_name # 服务器访问地址
    ```
4. 在服务器修改solr_data目录归属, 否则无法正常启动solr的docker服务

    ```bash
        chown 8983:8983 solr_data # 没有该目录，则先手动创建
    ```

5. 启动 docker compose up -d --build

## TODOs

- [x] ~~全文检索~~
- [x] 三方登录
- [ ] 风控
- [x] 管理员删除帖子或评论
- [x] 发邮件
- [ ] 查询优化


## License

Released under the MIT license:

- [www.opensource.org/licenses/MIT](http://www.opensource.org/licenses/MIT)
