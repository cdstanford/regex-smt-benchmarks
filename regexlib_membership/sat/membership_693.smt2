;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <[\w\"\ '\#\* \=\',\.\\\(\)\/\-\$\{\}\[\]\|\*\?\+\^\&\:\%\;\!]+>
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "<\u00B5>"
(define-fun Witness1 () String (str.++ "<" (str.++ "\u{b5}" (str.++ ">" ""))))
;witness2: "\u00FD\u00C3<\u00AA>"
(define-fun Witness2 () String (str.++ "\u{fd}" (str.++ "\u{c3}" (str.++ "<" (str.++ "\u{aa}" (str.++ ">" ""))))))

(assert (= regexA (re.++ (re.range "<" "<")(re.++ (re.+ (re.union (re.range " " ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "_")(re.union (re.range "a" "}")(re.union (re.range "\u{aa}" "\u{aa}")(re.union (re.range "\u{b5}" "\u{b5}")(re.union (re.range "\u{ba}" "\u{ba}")(re.union (re.range "\u{c0}" "\u{d6}")(re.union (re.range "\u{d8}" "\u{f6}") (re.range "\u{f8}" "\u{ff}")))))))))))) (re.range ">" ">")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
