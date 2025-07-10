;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-1]?\d|2[0-3])([:]?[0-5]\d)?([:]?|[0-5]\d)?\s?(A|AM|P|p|a|PM|am|pm|pM|aM|Am|Pm)?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "2151\u00A0pm"
(define-fun Witness1 () String (str.++ "2" (str.++ "1" (str.++ "5" (str.++ "1" (str.++ "\u{a0}" (str.++ "p" (str.++ "m" ""))))))))
;witness2: "5:"
(define-fun Witness2 () String (str.++ "5" (str.++ ":" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.range "0" "1")) (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.opt (re.++ (re.opt (re.range ":" ":"))(re.++ (re.range "0" "5") (re.range "0" "9"))))(re.++ (re.opt (re.union (re.opt (re.range ":" ":")) (re.++ (re.range "0" "5") (re.range "0" "9"))))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}")))))(re.++ (re.opt (re.union (re.range "A" "A")(re.union (str.to_re (str.++ "A" (str.++ "M" "")))(re.union (re.union (re.range "P" "P")(re.union (re.range "a" "a") (re.range "p" "p")))(re.union (str.to_re (str.++ "P" (str.++ "M" "")))(re.union (str.to_re (str.++ "a" (str.++ "m" "")))(re.union (str.to_re (str.++ "p" (str.++ "m" "")))(re.union (str.to_re (str.++ "p" (str.++ "M" "")))(re.union (str.to_re (str.++ "a" (str.++ "M" "")))(re.union (str.to_re (str.++ "A" (str.++ "m" ""))) (str.to_re (str.++ "P" (str.++ "m" ""))))))))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
