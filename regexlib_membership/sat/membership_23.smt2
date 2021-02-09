;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[\d]{3}[\s\-]*[\d]{3}[\s\-]*[\d]{4}\s*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "695\xB\u00858899984\xC"
(define-fun Witness1 () String (seq.++ "6" (seq.++ "9" (seq.++ "5" (seq.++ "\x0b" (seq.++ "\x85" (seq.++ "8" (seq.++ "8" (seq.++ "9" (seq.++ "9" (seq.++ "9" (seq.++ "8" (seq.++ "4" (seq.++ "\x0c" ""))))))))))))))
;witness2: "1396184299\xA"
(define-fun Witness2 () String (seq.++ "1" (seq.++ "3" (seq.++ "9" (seq.++ "6" (seq.++ "1" (seq.++ "8" (seq.++ "4" (seq.++ "2" (seq.++ "9" (seq.++ "9" (seq.++ "\x0a" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
