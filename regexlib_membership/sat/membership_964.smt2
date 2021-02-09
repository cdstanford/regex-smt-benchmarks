;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\s*(?i:)((1[0-2])|(0[1-9])|([123456789])):(([0-5][0-9])|([123456789]))\s(am|pm)\s*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "08:1\u00A0pm\xB\xD\u00A0"
(define-fun Witness1 () String (seq.++ "0" (seq.++ "8" (seq.++ ":" (seq.++ "1" (seq.++ "\xa0" (seq.++ "p" (seq.++ "m" (seq.++ "\x0b" (seq.++ "\x0d" (seq.++ "\xa0" "")))))))))))
;witness2: "08:56\xCam\u0085\xD\u00A0"
(define-fun Witness2 () String (seq.++ "0" (seq.++ "8" (seq.++ ":" (seq.++ "5" (seq.++ "6" (seq.++ "\x0c" (seq.++ "a" (seq.++ "m" (seq.++ "\x85" (seq.++ "\x0d" (seq.++ "\xa0" ""))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.++ (re.range "1" "1") (re.range "0" "2"))(re.union (re.++ (re.range "0" "0") (re.range "1" "9")) (re.range "1" "9")))(re.++ (re.range ":" ":")(re.++ (re.union (re.++ (re.range "0" "5") (re.range "0" "9")) (re.range "1" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ (re.union (str.to_re (seq.++ "a" (seq.++ "m" ""))) (str.to_re (seq.++ "p" (seq.++ "m" ""))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
