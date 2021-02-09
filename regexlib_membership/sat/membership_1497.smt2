;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((\(?0\d{4}\)?\s?\d{3}\s?\d{3})|(\(?0\d{3}\)?\s?\d{3}\s?\d{4})|(\(?0\d{2}\)?\s?\d{4}\s?\d{4}))(\s?\#(\d{4}|\d{3}))?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(09493 673935\u0085#089"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "0" (seq.++ "9" (seq.++ "4" (seq.++ "9" (seq.++ "3" (seq.++ " " (seq.++ "6" (seq.++ "7" (seq.++ "3" (seq.++ "9" (seq.++ "3" (seq.++ "5" (seq.++ "\x85" (seq.++ "#" (seq.++ "0" (seq.++ "8" (seq.++ "9" "")))))))))))))))))))
;witness2: "0151 1689298"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "1" (seq.++ "5" (seq.++ "1" (seq.++ " " (seq.++ "1" (seq.++ "6" (seq.++ "8" (seq.++ "9" (seq.++ "2" (seq.++ "9" (seq.++ "8" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 3 3) (re.range "0" "9")))))))))(re.union (re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 4 4) (re.range "0" "9"))))))))) (re.++ (re.opt (re.range "(" "("))(re.++ (re.range "0" "0")(re.++ ((_ re.loop 2 2) (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) ((_ re.loop 4 4) (re.range "0" "9")))))))))))(re.++ (re.opt (re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.range "#" "#") (re.union ((_ re.loop 4 4) (re.range "0" "9")) ((_ re.loop 3 3) (re.range "0" "9")))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
