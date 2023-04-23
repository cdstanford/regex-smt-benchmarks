;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\+?\(?\d+\)?(\s|\-|\.)?\d{1,3}(\s|\-|\.)?\d{4}$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "90\xC14835"
(define-fun Witness1 () String (str.++ "9" (str.++ "0" (str.++ "\u{0c}" (str.++ "1" (str.++ "4" (str.++ "8" (str.++ "3" (str.++ "5" "")))))))))
;witness2: "+(82938788"
(define-fun Witness2 () String (str.++ "+" (str.++ "(" (str.++ "8" (str.++ "2" (str.++ "9" (str.++ "3" (str.++ "8" (str.++ "7" (str.++ "8" (str.++ "8" "")))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "+" "+"))(re.++ (re.opt (re.range "(" "("))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" ".")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\u{09}" "\u{0d}")(re.union (re.range " " " ")(re.union (re.range "-" ".")(re.union (re.range "\u{85}" "\u{85}") (re.range "\u{a0}" "\u{a0}"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re ""))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
