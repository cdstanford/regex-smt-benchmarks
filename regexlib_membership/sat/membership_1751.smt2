;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(/w|/W|[^<>+?$%{}&])+$
;---
(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "/w"
(define-fun Witness1 () String (str.++ "/" (str.++ "w" "")))
;witness2: "/W/W"
(define-fun Witness2 () String (str.++ "/" (str.++ "W" (str.++ "/" (str.++ "W" "")))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (str.to_re (str.++ "/" (str.++ "w" "")))(re.union (str.to_re (str.++ "/" (str.++ "W" ""))) (re.union (re.range "\u{00}" "#")(re.union (re.range "'" "*")(re.union (re.range "," ";")(re.union (re.range "=" "=")(re.union (re.range "@" "z")(re.union (re.range "|" "|") (re.range "~" "\u{ff}")))))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
