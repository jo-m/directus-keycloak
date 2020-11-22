FROM directus/directus:v8-apache

ADD Okta.php /var/directus/vendor/directus/oauth2-okta/src/Provider/Okta.php
ADD OktaResourceOwner.php /var/directus/vendor/directus/oauth2-okta/src/Provider/OktaResourceOwner.php
ADD logo.svg /var/directus/public/extensions/core/auth/okta/icon.svg

RUN git clone https://github.com/lucasfrey/directus-conditional-fields.git /tmp/directus-conditional-fields    && \
    mv /tmp/directus-conditional-fields/dist /var/directus/public/extensions/custom/interfaces                 && \
    rm -rf /tmp/directus-conditional-fields
