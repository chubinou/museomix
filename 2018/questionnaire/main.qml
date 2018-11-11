import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtMultimedia 5.9


Window {
	id: root
	width: 1050
	height: 1680
	Component.onCompleted: {
		root.showFullScreen()
	}

	property int scoreA: 0
	property int scoreB: 0
	property int scoreC: 0

	function updateScore( s )
	{
		switch (s) {
		case 0: root.scoreA += 1; break;
		case 1: root.scoreB += 1; break;
		case 2: root.scoreC += 1; break;
		default: break;
		}
	}

	function bestScore() {
		if (scoreA >= scoreB && scoreA >= scoreC)
			return 1
		else if ( scoreB >= scoreC )
			return 2
		else
			return 3
	}

	function goTextCoiffe() {
		if (scoreA >= scoreB && scoreA >= scoreC)
			return view.replace(textCoiffe_1)
		else if ( scoreB >= scoreC )
			return view.replace(textCoiffe_2)
		else
			return view.replace(textCoiffe_3)
	}

	function goBooth() {
		view.replace(fake)
		boothLayout.currentIndex = 1
		booth.reset()

	}

	Component {
		id: welcome
		Accueil {
			onNext: view.replace(q1)
			Component.onCompleted: {
				root.scoreA = 0
				root.scoreB = 0
				root.scoreC = 0
			}
		}
	}

	Component {
		id: q1
		Question {
			txtTitle: "La dentelle, vous en pensez quoi ?"
			txtA: "J'en ai ras la coiffe de faire ça tous les soirs... On n'y voit jamais assez et je m'embrouille toujours dans les fils"
			respAVal: 3
			txtB: "C'est magnifique, j'en acheté un nouveau modèle la semaine dernière, je vais demander un nouveau corsage à ma couturière !"
			respBVal: 1
			txtC: "ça appâte le client, pour sûr !"
			respCVal: 2
			onResp: {
				updateScore(val, weight)
				view.replace(ctx1)
			}
		}
	}

	Component {
		id: ctx1
		QuestionCtx {
			txtTitle: "La dentelle, vous en pensez quoi ?"
			txtBody: "À la fin du 19ème siècle, les femmes de la campagne continuaient à travailler le soir. Elles fabricaient de la dentelle, ce qui n'était pas toujours facile avant l'arrivée de l'électricité pour s'éclairer..."
			img: "file:./pic/01-dentelliere.png"
			onNext: view.replace(q2)
		}
	}

	Component {
		id: q2
		Question {
			txtTitle: "Aujourd'hui est un jour particulier pour vous..."
			txtA: "Oui, je me marie. Je vais donc quitter ma famille, emmener mon armoire et m'installer dans la maison de mon nouveau mari. Mais au moins, il n'est pas pauvre..."
			respAVal: 1
			txtB: "Non, rien d'exceptionnel : la traite, nourrir les poules, faire le beurre... J'espère juste croiser Hippolyte et ses beaux yeux qui me font frissonner jusqu'aux orteils (et encore, je ne vous dis pas tout)"
			respBVal: 2
			txtC: "Oui, cela fait ENFIN plus d'un an que ce crétin d'Albert est mort, je vais enfin pouvoir reprendre une vie sociale !"
			respCVal: 666
			onResp: {
				updateScore(val, weight)
				view.replace(ctx2)
			}
		}
	}

	Component {
		id: ctx2
		QuestionCtx {
			txtTitle: "Aujourd'hui est un jour particulier pour vous..."
			txtBody: "Lors du mariage de sa fille, un père normand devait lui fournir une armoire. Symboliquement, l'armoire quittait le domicile familial le jour de la cérémonie pour accompagner la mariée chez son mari."
			img: "file:./pic/02-armoire.png"
			onNext: view.replace(q3)
		}
	}

	Component {
		id: q3
		Question {
			txtTitle: "Vendredi prochain, grande lessive ! Comment abordez-vous cet événement ?"
			txtA: "Très sereinement, la vieille Berthe va passer ici en premier avant de faire le tour de la ville. Elle ramènera tout cela la semaine prochaine, comme d'habitude."
			respAVal: 1
			txtB: "Avec un peu d'appréhension. C'est la première fois que je vais devoir participer, et comme cette semaine on n'avait pas trop à manger, je risque de faire un malaise."
			respBVal: 2
			txtC: "La lessive ? Mouhahaha, tu rigoles ? Si j'enlève ma robe, je sors comment ? À oilpé ?"
			respCVal: 3
			weightC: 0

			onResp: {
				updateScore(val, weight)
				view.replace(ctx3)
			}
		}
	}

	Component {
		id: ctx3
		QuestionCtx {
			txtTitle: "Vendredi prochain, grande lessive ! Comment abordez-vous cet événement ?"
			txtBody: "La lessive était un moment important. Les plus riches confiaient leur linge aux femmes plus modestes, qui allaient ensemble au lavoir. Le travail était très physique, et très long."
			img: "file:./pic/03-lavoire.png"
			onNext: view.replace(q4)
		}
	}

	Component {
		id: q4
		Question {
			txtTitle: "Vous croisez la grande Marie..."
			txtA: "Ça tombe bien, je voulais la voir. Elle a découpé une de ses vieilles robes et elle m'a promis un bout de tissu pour ma prochaine coiffe."
			respAVal: 2
			txtB: "Ça tombe bien, je voudrais lui demander de me livrer des oeufs en plus pour le repas de funérailles du vieux Pierre."
			respBVal: 3
			txtC: "Je lui rentre dans le lard. Elle m'a piqué mon mec, quand même !"
			respCVal: 1
			weightC: 0

			onResp: {
				updateScore(val, weight)
				view.replace(ctx4)
			}
		}
	}

	Component {
		id: ctx4
		QuestionCtx {
			txtTitle: "Vous croisez la grande Marie..."
			txtBody: "Si vous croisiez la grande Marie, il est fort probable que vous ne compreniez rien à ce qu'elle dit... Pas si facile, le Normand !"
			img: "file:./pic/04-eglise.png"
			onNext: view.replace(q5)
		}
	}

	Component {
		id: q5
		Question {
			txtTitle: "Vous allez à la messe. On peut vous croiser..."
			txtA: "Sur le Chemin de la Croix-Tremay. Je retrouve la fille de la ferme Belin pour faire le chemin jusqu'à Marcey-les-Grèves. De temps en temps, je vais jusqu'à Avranches pour retrouver les autres filles du canton."
			respAVal: 1
			txtB: "Devant le Parvis de l'église, une escarcelle à la main... Les gens sont plus généreux le jour du Seigneur."
			respBVal: 2
			txtC: "Non, je prends la diligence avec ma mère pour ne pas souiller ma crinoline."
			respCVal: 3
			weightC: 0

			onResp: {
				updateScore(val, weight)
				view.replace(ctx5)
			}
		}
	}

	Component {
		id: ctx5
		QuestionCtx {
			txtTitle: "Vous allez à la messe. On peut vous croiser..."
			txtBody: " La crinoline est la petite culotte des riches du 19ème ! Il s'agit d'un jupon en étoffe formée d'une trame en crin de cheval (d'où son nom) et de lin ou de coton pour les plus riches."
			img: "file:./pic/05-marie.png"
			onNext: view.replace(q6)
		}
	}

	Component {
		id: q6
		Question {
			txtTitle: "Votre bijou préféré, c'est..."
			txtA: "ma Croix-Jeannette, que j'ai hérité de ma grand-mère et qui me rapproche de Dieu."
			respAVal: 2
			txtB: "ma bague de Foi, que mon fiancé m'a offerte et qui me rappelle que mon mariage approche."
			respBVal: 1
			txtC: "Le magnifique collier d'esclavage de la fille du notaire. Depuis son mariage, il s'est enrichi de trois rangs supplémentaires, un pour chaque enfant. Ça doit être lourd... mais c'est beau !"
			respCVal: 3
			weightC: 0

			onResp: {
				updateScore(val, weight)
				view.replace(ctx6_2)

				//switch (val) {
				//	case 1: view.replace(ctx6_1); break;
				//	case 2: view.replace(ctx6_2); break;
				//	case 3: view.replace(ctx6_3); break;
				//}
			}
		}
	}


	Component {
		id: ctx6_1
		QuestionCtx {
			txtTitle: "Votre bijou préféré, c'est..."
			txtBody: "Traditionnellement, une Croix-Jeannette était achetée par une jeune fille en âge de se louer, c'est-à-dire de commencer à travailler pour une famille plus aisée en tant que domestique. VOIR DANS LES COLLECTIONS DU MUSE Or, 19ème siècle"
			onNext: goTextCoiffe()
		}
	}

	Component {
		id: ctx6_2
		QuestionCtx {
			txtTitle: "Votre bijou préféré, c'est..."
			//FIXME text????
			txtBody: "Les bagues de foi étaient offertes par leur promis lors des fiançailles."
			img: "file:./pic/06-bijoux.png"
			onNext: goTextCoiffe()
		}
	}

	Component {
		id: ctx6_3
		QuestionCtx {
			txtTitle: "Votre bijou préféré, c'est..."
			//FIXME text????
			txtBody: " Un collier d'Esclavage était offert aux femmes lors de leur mariage. On rajoutait une chaînette à la naissance de chaque enfant."
			onNext: goTextCoiffe()
		}
	}

	Component {
		id: textCoiffe_1
		TextCoiffe {
			txtTitle: "Vous portez un papillon d'Avranches"
			img: "file:./pic/coiffe-marriage.png"
			txtBody: "Cette coiffe était probablement réservée aux jeunes femmes à marier ou tout juste fiancées. Elle est tellement encombrante qu'il est évidemment impossible de travailler avec. Vous êtes donc oisive : soit juste aujourd'hui pour une cérémonie particulière, soit... tout le temps, si vous êtes riche."
			onNext: {
				view.replace(takeCoiffe)
			}
		}
	}

	Component {
		id: textCoiffe_2
		TextCoiffe {
			txtTitle: "Vous portez un bonnet de travail du Cotentin"
			img: "file:./pic/coiffe-jeune.png"
			txtBody: "Vous n'êtes pas riche, sans être dans le besoin. Vous devez travailler pour vivre : votre bonnet ne doit pas être trop encombrant, mais couvrir correctement vos cheveux. Vous êtes probablement mariée, car votre couvre-chef est très sobre"
			onNext: {
				view.replace(takeCoiffe)
			}
		}
	}

	Component {
		id: textCoiffe_3
		TextCoiffe {
			txtTitle: "Vous portez un bonnette de Bayeux de demi-deuil"
			img: "file:./pic/coiffe-deuille.png"
			txtBody: "Votre mari est mort il y a déjà plus d'un an. Vous êtes encore en deuil, mais vous avez le droit de reprendre un semblant de vie sociale. Votre coiffe est donc encore sobre, mais comprend de nouveau quelques décorations."
			onNext: {
				view.replace(takeCoiffe)
			}
		}
	}


	Component {
		id: takeCoiffe
		TakeCoiffeWeak {
			targetCoiffe: root.bestScore()
			onNext: goBooth()
		}
	}

	Component {
		id: presentationPhoto
		PresentationPhoto {
			onNext: {
				view.replace(thanks)
			}
		}
	}

	Component {
		id: thanks
		Thanks {
			onNext: {
				view.replace(welcome)
			}
		}
	}

	Component {
		id: fake
		Item {}
	}

	Image {
		anchors.fill: parent
		source: "file:./pic/bg.jpg"
	}

	StackLayout {
		id: boothLayout
		currentIndex: 0

		StackView {
			id: view
			anchors.fill: parent
			initialItem: welcome
			focus: true

			replaceEnter: Transition {
				YAnimator {
					from: root.height
					to: 0
				}
			}

			replaceExit: Transition {
				YAnimator {
					from: 0
					to: -root.height
				}
			}
		}

		Booth {
			id: booth
			onNext: {
				if (boothLayout.currentIndex !== 1)
					return;
				boothLayout.currentIndex = 0
				booth.active = false
				view.replace(presentationPhoto)
			}
		}
	}
}
