;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = /(A|B|AB|O)[+-]/
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "\u00BE/AB-/"
(define-fun Witness1 () String (str.++ "\u{be}" (str.++ "/" (str.++ "A" (str.++ "B" (str.++ "-" (str.++ "/" "")))))))
;witness2: "/O+/"
(define-fun Witness2 () String (str.++ "/" (str.++ "O" (str.++ "+" (str.++ "/" "")))))

(assert (= regexA (re.++ (re.range "/" "/")(re.++ (re.union (re.range "A" "B")(re.union (str.to_re (str.++ "A" (str.++ "B" ""))) (re.range "O" "O")))(re.++ (re.union (re.range "+" "+") (re.range "-" "-")) (re.range "/" "/"))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
