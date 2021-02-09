;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*\(?(020[7,8]{1}\)?[ ]?[1-9]{1}[0-9{2}[ ]?[0-9]{4})|(0[1-8]{1}[0-9]{3}\)?[ ]?[1-9]{1}[0-9]{2}[ ]?[0-9]{3})\s*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "08009)874979"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "8" (seq.++ "0" (seq.++ "0" (seq.++ "9" (seq.++ ")" (seq.++ "8" (seq.++ "7" (seq.++ "4" (seq.++ "9" (seq.++ "7" (seq.++ "9" "")))))))))))))
;witness2: "(0207) 139918"
(define-fun Witness2 () String (seq.++ "(" (seq.++ "0" (seq.++ "2" (seq.++ "0" (seq.++ "7" (seq.++ ")" (seq.++ " " (seq.++ "1" (seq.++ "3" (seq.++ "9" (seq.++ "9" (seq.++ "1" (seq.++ "8" ""))))))))))))))

(assert (= regexA (re.union (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "(" "(")) (re.++ (str.to_re (seq.++ "0" (seq.++ "2" (seq.++ "0" ""))))(re.++ (re.union (re.range "," ",") (re.range "7" "8"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.range " " " "))(re.++ (re.range "1" "9")(re.++ (re.opt (re.union (re.range " " " ")(re.union (re.range "0" "9")(re.union (re.range "[" "[")(re.union (re.range "{" "{") (re.range "}" "}")))))) ((_ re.loop 4 4) (re.range "0" "9"))))))))))) (re.++ (re.++ (re.range "0" "0")(re.++ (re.range "1" "8")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.range " " " "))(re.++ (re.range "1" "9")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range " " " ")) ((_ re.loop 3 3) (re.range "0" "9"))))))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
