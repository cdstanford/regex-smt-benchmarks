;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((([\*]{1}){1})|((\*\/){0,1}(([0-9]{1}){1}|(([1-5]{1}){1}([0-9]{1}){1}){1}))) ((([\*]{1}){1})|((\*\/){0,1}(([0-9]{1}){1}|(([1]{1}){1}([0-9]{1}){1}){1}|([2]{1}){1}([0-3]{1}){1}))) ((([\*]{1}){1})|((\*\/){0,1}(([1-9]{1}){1}|(([1-2]{1}){1}([0-9]{1}){1}){1}|([3]{1}){1}([0-1]{1}){1}))) ((([\*]{1}){1})|((\*\/){0,1}(([1-9]{1}){1}|(([1-2]{1}){1}([0-9]{1}){1}){1}|([3]{1}){1}([0-1]{1}){1}))|(jan|feb|mar|apr|may|jun|jul|aug|sep|okt|nov|dec)) ((([\*]{1}){1})|((\*\/){0,1}(([0-7]{1}){1}))|(sun|mon|tue|wed|thu|fri|sat)))$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "*/29 */12 */9 aug tue"
(define-fun Witness1 () String (str.++ "*" (str.++ "/" (str.++ "2" (str.++ "9" (str.++ " " (str.++ "*" (str.++ "/" (str.++ "1" (str.++ "2" (str.++ " " (str.++ "*" (str.++ "/" (str.++ "9" (str.++ " " (str.++ "a" (str.++ "u" (str.++ "g" (str.++ " " (str.++ "t" (str.++ "u" (str.++ "e" ""))))))))))))))))))))))
;witness2: "* * 6 sep mon"
(define-fun Witness2 () String (str.++ "*" (str.++ " " (str.++ "*" (str.++ " " (str.++ "6" (str.++ " " (str.++ "s" (str.++ "e" (str.++ "p" (str.++ " " (str.++ "m" (str.++ "o" (str.++ "n" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "*" "*") (re.++ (re.opt (str.to_re (str.++ "*" (str.++ "/" "")))) (re.union (re.range "0" "9") (re.++ (re.range "1" "5") (re.range "0" "9")))))(re.++ (re.range " " " ")(re.++ (re.union (re.range "*" "*") (re.++ (re.opt (str.to_re (str.++ "*" (str.++ "/" "")))) (re.union (re.range "0" "9")(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))))))(re.++ (re.range " " " ")(re.++ (re.union (re.range "*" "*") (re.++ (re.opt (str.to_re (str.++ "*" (str.++ "/" "")))) (re.union (re.range "1" "9")(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))))(re.++ (re.range " " " ")(re.++ (re.union (re.range "*" "*")(re.union (re.++ (re.opt (str.to_re (str.++ "*" (str.++ "/" "")))) (re.union (re.range "1" "9")(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))) (re.union (str.to_re (str.++ "j" (str.++ "a" (str.++ "n" ""))))(re.union (str.to_re (str.++ "f" (str.++ "e" (str.++ "b" ""))))(re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "r" ""))))(re.union (str.to_re (str.++ "a" (str.++ "p" (str.++ "r" ""))))(re.union (str.to_re (str.++ "m" (str.++ "a" (str.++ "y" ""))))(re.union (str.to_re (str.++ "j" (str.++ "u" (str.++ "n" ""))))(re.union (str.to_re (str.++ "j" (str.++ "u" (str.++ "l" ""))))(re.union (str.to_re (str.++ "a" (str.++ "u" (str.++ "g" ""))))(re.union (str.to_re (str.++ "s" (str.++ "e" (str.++ "p" ""))))(re.union (str.to_re (str.++ "o" (str.++ "k" (str.++ "t" ""))))(re.union (str.to_re (str.++ "n" (str.++ "o" (str.++ "v" "")))) (str.to_re (str.++ "d" (str.++ "e" (str.++ "c" "")))))))))))))))))(re.++ (re.range " " " ") (re.union (re.range "*" "*")(re.union (re.++ (re.opt (str.to_re (str.++ "*" (str.++ "/" "")))) (re.range "0" "7")) (re.union (str.to_re (str.++ "s" (str.++ "u" (str.++ "n" ""))))(re.union (str.to_re (str.++ "m" (str.++ "o" (str.++ "n" ""))))(re.union (str.to_re (str.++ "t" (str.++ "u" (str.++ "e" ""))))(re.union (str.to_re (str.++ "w" (str.++ "e" (str.++ "d" ""))))(re.union (str.to_re (str.++ "t" (str.++ "h" (str.++ "u" ""))))(re.union (str.to_re (str.++ "f" (str.++ "r" (str.++ "i" "")))) (str.to_re (str.++ "s" (str.++ "a" (str.++ "t" "")))))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
