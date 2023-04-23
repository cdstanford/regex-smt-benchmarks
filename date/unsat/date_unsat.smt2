(set-logic QF_S)
;---
; .NET regular expressions restricted to 7-bit characters
; membership in intersection of
; [0-9]{2}-[a-zA-Z]{3}-[0-9]{4}
; (?i:.*(jan|feb|mar|apr|may|jun).*)
; 3[01].*|[012].*
; (?(.*(?i:feb).*)([012].*)|.*)
; .*19..|.*20..
; (?(.*(?i:apr|jun).*)([012].*|30.*)|.*)
; .{10}(a|..)
; (the last constraint makes it unsat)
;---
(declare-const x String)
(assert (str.in_re x (re.inter (re.++ ((_ re.^ 10) re.allchar) (re.union (str.to_re "a") (re.++ re.allchar re.allchar))) (re.inter (re.inter (re.inter (re.inter (re.inter (re.++ (re.++ (re.++ (re.++ (re.++ ((_ re.^ 2) (re.range "0" "9")) (str.to_re "-")) ((_ re.^ 3) (re.union (re.range "A" "Z") (re.range "a" "z")))) (str.to_re "-")) ((_ re.^ 4) (re.range "0" "9"))) (str.to_re "")) (re.++ (re.++ re.all (re.union (re.union (re.union (re.union (re.union (re.++ (re.++ (re.union (str.to_re "J") (str.to_re "j")) (re.union (str.to_re "A") (str.to_re "a"))) (re.union (str.to_re "N") (str.to_re "n"))) (re.++ (re.++ (re.union (str.to_re "F") (str.to_re "f")) (re.union (str.to_re "E") (str.to_re "e"))) (re.union (str.to_re "B") (str.to_re "b")))) (re.++ (re.++ (re.union (str.to_re "M") (str.to_re "m")) (re.union (str.to_re "A") (str.to_re "a"))) (re.union (str.to_re "R") (str.to_re "r")))) (re.++ (re.++ (re.union (str.to_re "A") (str.to_re "a")) (re.union (str.to_re "P") (str.to_re "p"))) (re.union (str.to_re "R") (str.to_re "r")))) (re.++ (re.++ (re.union (str.to_re "M") (str.to_re "m")) (re.union (str.to_re "A") (str.to_re "a"))) (re.union (str.to_re "Y") (str.to_re "y")))) (re.++ (re.++ (re.union (str.to_re "J") (str.to_re "j")) (re.union (str.to_re "U") (str.to_re "u"))) (re.union (str.to_re "N") (str.to_re "n"))))) re.all)) (re.union (re.++ (re.++ (str.to_re "3") (re.range "0" "1")) re.all) (re.++ (re.range "0" "2") re.all))) (re.union (re.inter (re.++ (re.++ (re.++ (re.++ re.all (re.union (str.to_re "F") (str.to_re "f"))) (re.union (str.to_re "E") (str.to_re "e"))) (re.union (str.to_re "B") (str.to_re "b"))) re.all) (re.++ (re.range "0" "2") re.all)) (re.inter (re.comp (re.++ (re.++ (re.++ (re.++ re.all (re.union (str.to_re "F") (str.to_re "f"))) (re.union (str.to_re "E") (str.to_re "e"))) (re.union (str.to_re "B") (str.to_re "b"))) re.all)) re.all))) (re.union (re.++ (re.++ (re.++ re.all (str.to_re "19")) re.allchar) re.allchar) (re.++ (re.++ (re.++ re.all (str.to_re "20")) re.allchar) re.allchar))) (re.union (re.inter (re.++ (re.++ re.all (re.union (re.++ (re.++ (re.union (str.to_re "A") (str.to_re "a")) (re.union (str.to_re "P") (str.to_re "p"))) (re.union (str.to_re "R") (str.to_re "r"))) (re.++ (re.++ (re.union (str.to_re "J") (str.to_re "j")) (re.union (str.to_re "U") (str.to_re "u"))) (re.union (str.to_re "N") (str.to_re "n"))))) re.all) (re.union (re.++ (re.range "0" "2") re.all) (re.++ (str.to_re "30") re.all))) (re.inter (re.comp (re.++ (re.++ re.all (re.union (re.++ (re.++ (re.union (str.to_re "A") (str.to_re "a")) (re.union (str.to_re "P") (str.to_re "p"))) (re.union (str.to_re "R") (str.to_re "r"))) (re.++ (re.++ (re.union (str.to_re "J") (str.to_re "j")) (re.union (str.to_re "U") (str.to_re "u"))) (re.union (str.to_re "N") (str.to_re "n"))))) re.all)) re.all))))))
(check-sat)
;(get-model)
