;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = [a-zA-Z Á-Úá-ú][^1234567890]+$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00BE\u00F5\xBj"
(define-fun Witness1 () String (str.++ "\u{be}" (str.++ "\u{f5}" (str.++ "\u{0b}" (str.++ "j" "")))))
;witness2: ":\x1C\u00E6S"
(define-fun Witness2 () String (str.++ ":" (str.++ "\u{1c}" (str.++ "\u{e6}" (str.++ "S" "")))))

(assert (= regexA (re.++ (re.union (re.range " " " ")(re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\u{c1}" "\u{da}") (re.range "\u{e1}" "\u{fa}")))))(re.++ (re.+ (re.union (re.range "\u{00}" "/") (re.range ":" "\u{ff}"))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
