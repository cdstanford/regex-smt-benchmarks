;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(((ht|f)tp(s?))\://).*$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "ftp://"
(define-fun Witness1 () String (str.++ "f" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" "")))))))
;witness2: "https://"
(define-fun Witness2 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ "s" (str.++ ":" (str.++ "/" (str.++ "/" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.++ (re.union (str.to_re (str.++ "h" (str.++ "t" ""))) (re.range "f" "f"))(re.++ (str.to_re (str.++ "t" (str.++ "p" ""))) (re.opt (re.range "s" "s")))) (str.to_re (str.++ ":" (str.++ "/" (str.++ "/" "")))))(re.++ (re.* (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
