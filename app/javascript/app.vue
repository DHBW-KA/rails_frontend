<template>
    <div>
        <a class="button" href="https://vuejs.org/v2/guide/" target="_blank">
            <i class="fa fa-book"/>
            Vue Dokumentation
        </a>
        <hr/>
        <div class="level">
            <div class="level-left is-block"><h3 class="subtitle">Users in Chat</h3>
                <ul class="list is-hoverable">
                    <li v-for="user in users" :key="user.id" class="list-item">
                        {{ user.email }}
                        <span class="tag is-dark is-light" v-if="user.id === currentUserId">YOU</span>
                    </li>
                </ul>
            </div>
            <div class="level-right">
                <div class="panel container">
                    <div class="panel-heading">Chat</div>
                    <div class="panel-block is-block">
                        <p class="is-wrapped" v-for="message in messages" :key="message.id">
                            <span class="tag">{{message.user.email}}</span>{{message.msg}}</p>
                    </div>
                    <div class="panel-block">
                        <div class="container">
                            <form @submit="send">
                                <div class="field has-addons">
                                    <div class="control has-icons-left is-expanded">
                                        <input class="input" v-bind:class="{'is-danger': msgErrors.length!==0 }"
                                               v-model="msg"
                                               type="text" name="message[msg]"
                                               id="message_msg">
                                        <span class="icon is-small is-left"><i class="fas fa-user"></i></span>
                                        <p class="help is-danger" v-for="err in msgErrors">{{err}}</p>
                                    </div>
                                    <div class="control">
                                        <input type="submit" name="commit" value="Send" class="button is-primary"
                                               data-disable-with="Send">
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        props: ["jsonUsers", "jsonMessages", "currentUserId"],
        data: function () {
            return {
                users: JSON.parse(this.jsonUsers),
                messages: JSON.parse(this.jsonMessages),
                msg: "",
                msgErrors: []
            }
        },
        methods: {
            send(e) {
                e.preventDefault()
                e.stopPropagation()
                fetch(`/messages.json`, {
                    method: 'POST',
                    body: JSON.stringify({message: {msg: this.msg}}),
                    headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json',
                        'X-CSRF-Token': document.head.querySelector("[name='csrf-token']").getAttribute("content")
                    }
                }).then(response => {
                    if (response.ok)
                        response.json().then(m => {
                            m.user = this.users.find(u => u.id === m.user_id)
                            this.messages.push(m)
                        })
                    else
                        response.json().then(e => this.msgErrors = e.msg)
                })
            }
        }
    }
</script>

<style scoped>
    .level-right {
        padding: 2rem;
        max-width: 80%;
    }
</style>
