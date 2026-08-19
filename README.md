# Dr JSkill — Modular Skill Pack for Codex

Bản này là **overlay tái cấu trúc** cho repository `dr-jskill`, tập trung vào Codex nhưng vẫn giữ compatibility với các agent đọc `SKILL.md`.

Mục tiêu của cấu trúc mới:

- giữ nguyên toàn bộ `references/`, `scripts/`, `assets/` và `versions.json` của Dr JSkill hiện tại;
- tách một `SKILL.md` lớn thành các skill có scope rõ ràng;
- để Codex chỉ load phần kiến thức thực sự cần cho task;
- vẫn giữ đủ Angular, React, Vue và Vanilla JS;
- bổ sung hai skill optional cho Redis và Elasticsearch;
- giữ một root `SKILL.md` dạng compatibility/umbrella cho agent chưa hỗ trợ repo-local multi-skill.

> **Quan trọng:** file ZIP này là một **overlay**, không phải bản clone đầy đủ của upstream. Hãy áp dụng nó lên checkout hiện có của `dr-jskill`. Cách làm này cố ý tránh copy/ghi đè 16 reference gốc: các file reference gốc của bạn được giữ nguyên 100%.

---

## 1. Cấu trúc sau khi áp dụng

```text
dr-jskill/
├── AGENTS.md
├── README.md
├── SKILL.md                       # compatibility / umbrella skill
├── SKILLS.md                      # human-readable skill catalog
├── MIGRATION.md
├── versions.json                  # giữ nguyên upstream
│
├── .agents/
│   └── skills/
│       ├── spring-project/
│       │   └── SKILL.md
│       ├── spring-data-jpa/
│       │   └── SKILL.md
│       ├── spring-security/
│       │   └── SKILL.md
│       ├── spring-testing/
│       │   └── SKILL.md
│       ├── spring-frontend/
│       │   └── SKILL.md
│       ├── spring-container/
│       │   └── SKILL.md
│       ├── spring-deployment/
│       │   └── SKILL.md
│       ├── spring-redis/
│       │   └── SKILL.md
│       └── spring-elasticsearch/
│           └── SKILL.md
│
├── references/                    # GIỮ NGUYÊN toàn bộ upstream
│   ├── ANGULAR.md
│   ├── AZURE.md
│   ├── CONFIGURATION.md
│   ├── DATABASE.md
│   ├── DOCKER.md
│   ├── GIT.md
│   ├── GRAALVM.md
│   ├── JDTLS.md
│   ├── LOGGING.md
│   ├── PROJECT-SETUP.md
│   ├── REACT.md
│   ├── SECURITY.md
│   ├── SPRING-BOOT-4.md
│   ├── TEST.md
│   ├── VANILLA-JS.md
│   ├── VUE.md
│   └── skill-pack/                # policy bổ sung, không thay reference gốc
│       ├── DATABASE-POLICY.md
│       ├── SECURITY-POLICY.md
│       ├── FRONTEND-POLICY.md
│       ├── REDIS.md
│       └── ELASTICSEARCH.md
│
├── scripts/                       # giữ nguyên upstream + thêm installer/validator
├── assets/                        # giữ nguyên upstream
└── tools/
    └── apply-overlay.sh
```

### Vì sao không copy mỗi reference vào từng skill?

Ví dụ `ANGULAR.md` ~ lớn, `REACT.md`, `VUE.md`, `SECURITY.md`, `TEST.md` cũng vậy. Nếu copy chúng vào từng skill:

- version drift xảy ra rất nhanh;
- sửa một reference phải sửa nhiều bản;
- ZIP/repo phình lên;
- agent có thể đọc nhầm bản cũ.

Bản này dùng **canonical references ở root** và mỗi skill trỏ tới đúng file cần đọc.

---

## 2. Routing skill

| Task | Skill chính | Reference được đọc khi cần |
|---|---|---|
| Tạo project Spring Boot / bootstrap | `spring-project` | `SPRING-BOOT-4.md`, `PROJECT-SETUP.md`, `CONFIGURATION.md`, `LOGGING.md`, `JDTLS.md`, `GIT.md` |
| JPA/PostgreSQL/query/transaction | `spring-data-jpa` | `DATABASE.md` + `skill-pack/DATABASE-POLICY.md` |
| Authentication/authorization/JWT/OAuth2 | `spring-security` | `SECURITY.md` + `skill-pack/SECURITY-POLICY.md` |
| Unit/Integration/Testcontainers | `spring-testing` | `TEST.md` |
| Angular/React/Vue/Vanilla | `spring-frontend` | **chỉ** reference framework được chọn |
| Docker/AOT/GraalVM/CRaC | `spring-container` | `DOCKER.md`, `GRAALVM.md` |
| Azure/CI deployment | `spring-deployment` | `AZURE.md`, `DOCKER.md` |
| Redis cache/session/locking | `spring-redis` | `skill-pack/REDIS.md` |
| Elasticsearch full-text search | `spring-elasticsearch` | `skill-pack/ELASTICSEARCH.md` |

Điểm quan trọng là `spring-frontend` **không đọc cả 4 tài liệu FE** nếu task chỉ dùng Angular. Đây chính là progressive disclosure mà việc tách skill mang lại.

---

## 3. Áp dụng overlay lên fork hiện tại

Giải nén file overlay ở một thư mục bất kỳ, sau đó:

```bash
cd dr-jskill-skillpack-overlay
./tools/apply-overlay.sh /duong/dan/toi/dr-jskill
```

Script sẽ:

1. kiểm tra target có `references/`, `scripts/`, `assets/`, `versions.json`;
2. backup `README.md`, `SKILL.md`, `AGENTS.md` hiện tại;
3. thêm `.agents/skills/`;
4. thêm các policy/reference mới dưới `references/skill-pack/`;
5. thay root `README.md`, `SKILL.md`, `AGENTS.md`;
6. thêm installer và validator;
7. **không xóa bất kỳ upstream reference nào**.

Sau đó:

```bash
cd /duong/dan/toi/dr-jskill
./scripts/validate-skill-pack.sh
```

---

## 4. Dùng project-local với Codex

Codex scan repo-local skills từ `.agents/skills`, vì vậy khi mở Codex trong repository đã áp dụng overlay, không cần cài global.

Kiểm tra:

```text
/skills
```

Hoặc gọi explicit:

```text
$spring-project create a Spring Boot 4 application with Java 25 and PostgreSQL
```

```text
$spring-frontend add an Angular frontend to this project
```

```text
$spring-security secure this REST API with Keycloak/OIDC
```

Codex cũng có thể implicit invoke skill dựa vào `description`.

---

## 5. Cài global cho Codex

Nếu muốn dùng pack này cho nhiều repository:

```bash
./scripts/install-codex-global.sh
```

Script tạo:

```text
~/.agents/dr-jskill-pack/
```

với toàn bộ skill pack + shared references/scripts/assets, sau đó tạo symlink:

```text
~/.agents/skills/spring-project
~/.agents/skills/spring-data-jpa
...
```

Cách này giúp các relative path tới shared references vẫn đúng.

Để cài vào vị trí khác:

```bash
DR_JSKILL_INSTALL_DIR="$HOME/.agents/my-java-pack" \
  ./scripts/install-codex-global.sh
```

---

## 6. Cách prompt sau khi tách skill

### Tạo project

```text
Create a Spring Boot 4 application using Java 25, Maven and PostgreSQL.
Use Angular for the frontend.
Do not add Redis or Elasticsearch yet.
```

Thường Codex sẽ dùng `spring-project`, và khi sang phần frontend có thể dùng thêm `spring-frontend`.

### Security

```text
Add Keycloak authentication.
The backend is a stateless OAuth2 Resource Server.
Use roles for authorization.
```

Task này nên match `spring-security`, không cần load Docker/Angular/Test references.

### JPA

```text
Implement Order and OrderItem with JPA.
Add pagination and avoid N+1 queries.
Use Flyway for schema migrations.
```

Task này nên match `spring-data-jpa`.

### Redis chỉ khi cần

```text
Cache ProductCategory for 30 minutes with Redis.
Design cache keys and invalidation rules.
```

### Elasticsearch chỉ khi cần

```text
Add full-text product search using Elasticsearch.
PostgreSQL remains the source of truth.
```

---

## 7. Nguyên tắc của pack

### `AGENTS.md`

Dùng cho **quy tắc làm việc trên repository**:

- Maven only;
- Java 25/Spring Boot 4 baseline;
- không đọc `.env`;
- version phải đi qua `versions.json`;
- không sửa reference khác khi task không liên quan;
- validation trước khi kết thúc.

### `SKILL.md`

Dùng cho **workflow theo task**.

Ví dụ:

- `spring-security/SKILL.md` chỉ nói cách xử lý security;
- `spring-frontend/SKILL.md` chỉ nói cách chọn và xử lý FE;
- `spring-data-jpa/SKILL.md` chỉ nói persistence.

### `references/`

Dùng cho kiến thức dài, examples, caveat, framework-specific details.

### `scripts/`

Dùng khi việc cần deterministic behavior hoặc automation.

---

## 8. Các thay đổi policy so với upstream

Tôi giữ nguyên reference upstream để bạn có thể đối chiếu, nhưng thêm policy layer mới.

### Database

Upstream Dr JSkill ưu tiên `ddl-auto`. Pack mới:

- production: `ddl-auto=validate`;
- schema migration: ưu tiên Flyway;
- `ddl-auto=update` chỉ dùng khi user thực sự muốn prototype/dev convenience;
- tests có thể dùng create/create-drop tùy test strategy.

Chi tiết: `references/skill-pack/DATABASE-POLICY.md`.

### Security

Pack mới ưu tiên:

1. OAuth2 Resource Server / OIDC / Keycloak khi có external IdP;
2. Spring Security native JWT support (`JwtDecoder`, resource server);
3. custom JWT filter/JJWT chỉ khi use case thực sự cần.

Chi tiết: `references/skill-pack/SECURITY-POLICY.md`.

### Frontend

Giữ đủ:

- Angular
- React
- Vue
- Vanilla JS

Nhưng `spring-frontend` chỉ load đúng framework được chọn.

Chi tiết: `references/skill-pack/FRONTEND-POLICY.md`.

---

## 9. Có nên tiếp tục tách nhỏ hơn?

Chưa.

Ví dụ không nên tách:

```text
spring-angular
spring-react
spring-vue
spring-vanilla
```

trừ khi từng FE bắt đầu có workflow rất khác nhau hoặc team riêng.

Tương tự:

```text
spring-jpa
spring-postgres
spring-pagination
spring-transaction
```

là quá nhỏ cho pack hiện tại.

Rule thực dụng:

> Tách skill khi **trigger, workflow và validation** khác nhau.  
> Giữ làm reference khi chỉ là **kiến thức chi tiết của cùng workflow**.

---

## 10. File quan trọng nên đọc trước

1. `SKILLS.md`
2. `.agents/skills/spring-project/SKILL.md`
3. `.agents/skills/spring-frontend/SKILL.md`
4. `.agents/skills/spring-data-jpa/SKILL.md`
5. `references/skill-pack/DATABASE-POLICY.md`
6. `references/skill-pack/SECURITY-POLICY.md`
7. `MIGRATION.md`

Sau khi xem cấu trúc này, bạn có thể tiếp tục chỉnh description/trigger theo cách làm thực tế của team.
