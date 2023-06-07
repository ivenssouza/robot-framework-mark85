import requests

api_url = 'http://localhost:3333/'



def api_new_user_lib(user):

    # data = {'name':user.name,
    #         'email':user.email,
    #         'password':user.password}
    response = requests.post(api_url + 'users', user)



#url2 = 'http://localhost:3333/sessions'
#data2 = {'email':'z@z.com',
#        'password':'123456'}
#response2 = requests.post(url2, data2)
#print(response2.text)

#const signIn = useCallback(async ({ email, password }) => {
#const response = await api.post("sessions", {
#    email,
#    password,
#});



#const formData = {
#          name,
#          tags
#        };
#        api.post("/tasks", formData)
#          .then(response => {
#            setLoading(false);
#            history.push("/tasks");
#          }).catch(error => {
#            const { message } = error.response.data
#            if (message === 'Duplicated task!') {
#              setNotice({
#                display: true,
#                type: 'error',
#                message: 'Oops! Tarefa duplicada.'
#              })
#            }
#            setLoading(false);
#          })


#const getTasks = async () => {
#    api
#      .get<Tasks[]>("/tasks")
#      .then(response => {
#        setTasks(response.data);
#      });
#  }
#  useEffect(() => {
#    getTasks()
#  }, []);

#  function handleSelectTask(task: Tasks) {
#    api
#      .put(`/tasks/${task._id}/${task.is_done ? 'todo' : 'done'}`)
#      .then(response => {
#        getTasks();
#      });
#  }

#  function handleDeleteTask(task_id: string) {
#    api
#      .delete("/tasks/" + task_id)
#      .then(response => {
#        getTasks();
#      });
#  }