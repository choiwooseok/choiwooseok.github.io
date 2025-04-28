---
title: "github pages 유니버설 애널리틱스 to GA4"
date: 2026-02-07 22:34:00 +0900
categories: GA4
---

- 잊고 있던 애널리틱스. 오랜만에 켜보니 깃헙 페이지가 연결이 안되어있다. 과거에 해뒀을텐데...
- 23년도 7월 부터 UA는 지원이 중단 되었다. GA4로 바꿔줘야 겠다.

1. 지금 이 깃헙 pages는 jekyll 이니까 설정파일에서 탭이 있었던거 같다.
   -  _config.yml을 확인.

    ```yml
    analytics:
    provider               : "google"
    google:
        tracking_id          : "UA-154480928-1"
        anonymize_ip         : false # true, false (default)    
    ```

   - 역시 예전에 UA로 되있어서 이제 연결이 끊어진거 였다.

2. GA4 에서 태그 연결 직접설치 페이지에 있는 스크립트를 확인.
    ```js
    <!-- Google tag (gtag.js) -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=G-S762M9ZDE3"></script>
    <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());

    gtag('config', 'G-S762M9ZDE3');
    </script>
    ```

3. 아이디가 그냥 다 박힌 스크립트를 붙이기 싫다 그러니까 설정으로 추가해서 빼주기.(_config.yml)

    ```yml
    analytics:
    provider               : "google"
    google:
        tracking_id          : "UA-154480928-1"
        measurement_id       : "G-S762M9ZDE3"
        anonymize_ip         : false # true, false (default)    
    ```


4. analytics.html 을 확인해보면 그냥 프로바이더명 따라서 _includes/analytics-providers/ 하위의 html 분기를 탄다.

{% raw %}
```liquid
{% if jekyll.environment == 'production' and site.analytics.provider and page.analytics != false %}

{% case site.analytics.provider %}
{% when "google" %}
  {% include /analytics-providers/google.html %}
{% when "google-universal" %}
  {% include /analytics-providers/google-universal.html %}
{% when "google-gtag" %}
  {% include /analytics-providers/google-gtag.html %}
{% when "custom" %}
  {% include /analytics-providers/custom.html %}
{% endcase %}

{% endif %}
 ```
{% endraw %}

- 프로바이더 설정을 바꿔주자. (_config.yml)

    ```yml
    analytics:
    provider               : "google-gtag"
    google:
        tracking_id          : "UA-154480928-1"
        measurement_id       : "G-S762M9ZDE3"
        anonymize_ip         : false # true, false (default)    
    ```


1. _includes/analytics-providers/google-gtag.html 수정하기
   - 기존 부분을 주석처리 해버리고 GA4에서 복사해온 스크립트 (2번 과정) 를 붙여넣어주기
   - id 뒷자리를 설정에 추가한 변수명으로 갈아끼워주기

    ```js
    <!-- Global site tag (gtag.js) - Google Analytics -->

    <!-- <script async src="https://www.googletagmanager.com/gtag/js?id={{ site.analytics.google.tracking_id }}"></script>
    <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());

    gtag('config', '{{ site.analytics.google.tracking_id }}', { 'anonymize_ip': {{ site.analytics.google.anonymize_ip | default: false }}});
    </script> -->

    <!-- Google tag (gtag.js) -->
    <script async src="https://www.googletagmanager.com/gtag/js?id={{ site.analytics.google.measurement_id }}"></script>
    <script>
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());

    gtag('config', '{{ site.analytics.google.measurement_id }}');
    </script>
    ```

2. 커밋후 GA 확인 끝~