<<<<<<< HEAD
# ProjetP4
Bande de suceurs d'aubergines
=======
-Pour commencer Git c'est un programme (créer par Linus Torvals ) qui permet la gestion de projet.
 Il y a un dépot (voir lien plus haut) qui est hébergé chez GitHub. Ce dépot contient tous les fichiers que l'on devra utiliser.
-Git permet de voir toutes les modifications qui ont été faites et de revenir super facilement aux versions précédentes. 
Donc quand vous pensez avoir quelque chose bien, vous faites ce qu'on appel un "commit". Quand l'on fait un commit ça 
veut dire "tiens git, j'ai modifié tel et tel fichier (ils sont indiqués à l'aide de la commande "git add"). Je voudrais 
que tu retiennes ces modifications. Je te donne un message simple pour le commit histoire que tu saches en quoi consiste 
les nouveles modifs." Une fois que ce commit est fait, il est facile d'y revenir.
Les commit sont sur vos ordinateurs et uniquement sur vos ordinateurs jusqu'au moment ou vous faites que l'on appele un "push". 
Un push ça veut dire que vous envoyer vos commits au dépot.

- un Pull est une commande qu'ill faut faire assez souvent. Cela permet de mettre sur vos ordinateurs les nouvelles données sur le dépot.

-Méthode générale de dévellopement: 
	creer une branche
	while(modif à faire){
		modifier les fichiers
		if( la modif est satisfaisante)
			faire une commit
		if( c'est necessaire de pull)
			faire un pull
	}
	if(satisfaisant)
		merger la branche avec la branche master
		detruire la branche

>>>>>>> origin/master
