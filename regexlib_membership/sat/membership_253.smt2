;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((([\*]{1}){1})|((\*\/){0,1}(([0-9]{1}){1}|(([1-5]{1}){1}([0-9]{1}){1}){1}))) ((([\*]{1}){1})|((\*\/){0,1}(([0-9]{1}){1}|(([1]{1}){1}([0-9]{1}){1}){1}|([2]{1}){1}([0-3]{1}){1}))) ((([\*]{1}){1})|((\*\/){0,1}(([1-9]{1}){1}|(([1-2]{1}){1}([0-9]{1}){1}){1}|([3]{1}){1}([0-1]{1}){1}))) ((([\*]{1}){1})|((\*\/){0,1}(([1-9]{1}){1}|(([1-2]{1}){1}([0-9]{1}){1}){1}|([3]{1}){1}([0-1]{1}){1}))|(jan|feb|mar|apr|may|jun|jul|aug|sep|okt|nov|dec)) ((([\*]{1}){1})|((\*\/){0,1}(([0-7]{1}){1}))|(sun|mon|tue|wed|thu|fri|sat)))$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "*/29 */12 */9 aug tue"
(define-fun Witness1 () String (seq.++ "*" (seq.++ "/" (seq.++ "2" (seq.++ "9" (seq.++ " " (seq.++ "*" (seq.++ "/" (seq.++ "1" (seq.++ "2" (seq.++ " " (seq.++ "*" (seq.++ "/" (seq.++ "9" (seq.++ " " (seq.++ "a" (seq.++ "u" (seq.++ "g" (seq.++ " " (seq.++ "t" (seq.++ "u" (seq.++ "e" ""))))))))))))))))))))))
;witness2: "* * 6 sep mon"
(define-fun Witness2 () String (seq.++ "*" (seq.++ " " (seq.++ "*" (seq.++ " " (seq.++ "6" (seq.++ " " (seq.++ "s" (seq.++ "e" (seq.++ "p" (seq.++ " " (seq.++ "m" (seq.++ "o" (seq.++ "n" ""))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "*" "*") (re.++ (re.opt (str.to_re (seq.++ "*" (seq.++ "/" "")))) (re.union (re.range "0" "9") (re.++ (re.range "1" "5") (re.range "0" "9")))))(re.++ (re.range " " " ")(re.++ (re.union (re.range "*" "*") (re.++ (re.opt (str.to_re (seq.++ "*" (seq.++ "/" "")))) (re.union (re.range "0" "9")(re.union (re.++ (re.range "1" "1") (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3"))))))(re.++ (re.range " " " ")(re.++ (re.union (re.range "*" "*") (re.++ (re.opt (str.to_re (seq.++ "*" (seq.++ "/" "")))) (re.union (re.range "1" "9")(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))))(re.++ (re.range " " " ")(re.++ (re.union (re.range "*" "*")(re.union (re.++ (re.opt (str.to_re (seq.++ "*" (seq.++ "/" "")))) (re.union (re.range "1" "9")(re.union (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (re.range "3" "3") (re.range "0" "1"))))) (re.union (str.to_re (seq.++ "j" (seq.++ "a" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "f" (seq.++ "e" (seq.++ "b" ""))))(re.union (str.to_re (seq.++ "m" (seq.++ "a" (seq.++ "r" ""))))(re.union (str.to_re (seq.++ "a" (seq.++ "p" (seq.++ "r" ""))))(re.union (str.to_re (seq.++ "m" (seq.++ "a" (seq.++ "y" ""))))(re.union (str.to_re (seq.++ "j" (seq.++ "u" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "j" (seq.++ "u" (seq.++ "l" ""))))(re.union (str.to_re (seq.++ "a" (seq.++ "u" (seq.++ "g" ""))))(re.union (str.to_re (seq.++ "s" (seq.++ "e" (seq.++ "p" ""))))(re.union (str.to_re (seq.++ "o" (seq.++ "k" (seq.++ "t" ""))))(re.union (str.to_re (seq.++ "n" (seq.++ "o" (seq.++ "v" "")))) (str.to_re (seq.++ "d" (seq.++ "e" (seq.++ "c" "")))))))))))))))))(re.++ (re.range " " " ") (re.union (re.range "*" "*")(re.union (re.++ (re.opt (str.to_re (seq.++ "*" (seq.++ "/" "")))) (re.range "0" "7")) (re.union (str.to_re (seq.++ "s" (seq.++ "u" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "m" (seq.++ "o" (seq.++ "n" ""))))(re.union (str.to_re (seq.++ "t" (seq.++ "u" (seq.++ "e" ""))))(re.union (str.to_re (seq.++ "w" (seq.++ "e" (seq.++ "d" ""))))(re.union (str.to_re (seq.++ "t" (seq.++ "h" (seq.++ "u" ""))))(re.union (str.to_re (seq.++ "f" (seq.++ "r" (seq.++ "i" "")))) (str.to_re (seq.++ "s" (seq.++ "a" (seq.++ "t" "")))))))))))))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
