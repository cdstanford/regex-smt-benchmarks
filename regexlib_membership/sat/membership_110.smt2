;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^((([\+][\s]{0,1})|([0]{2}[\s-]{0,1}))([358]{3})([\s-]{0,1})|([0]{1}))(([1-9]{1}[0-9]{0,1})([\s-]{0,1})([0-9]{2,4})([\s-]{0,1})([0-9]{2,4})([\s-]{0,1}))([0-9]{0,3}){1}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "00 8888\xB036\u00859412\u00A08"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "0" (seq.++ " " (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "8" (seq.++ "\x0b" (seq.++ "0" (seq.++ "3" (seq.++ "6" (seq.++ "\x85" (seq.++ "9" (seq.++ "4" (seq.++ "1" (seq.++ "2" (seq.++ "\xa0" (seq.++ "8" "")))))))))))))))))))
;witness2: "08998\u00850134\u0085"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "\x85" (seq.++ "0" (seq.++ "1" (seq.++ "3" (seq.++ "4" (seq.++ "\x85" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.union (re.++ (re.range "+" "+") (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))) (re.++ ((_ re.loop 2 2) (re.range "0" "0")) (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))))(re.++ ((_ re.loop 3 3) (re.union (re.range "3" "3")(re.union (re.range "5" "5") (re.range "8" "8")))) (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))) (re.range "0" "0"))(re.++ (re.++ (re.++ (re.range "1" "9") (re.opt (re.range "0" "9")))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ ((_ re.loop 2 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ ((_ re.loop 2 4) (re.range "0" "9")) (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))))(re.++ ((_ re.loop 0 3) (re.range "0" "9")) (str.to_re "")))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
