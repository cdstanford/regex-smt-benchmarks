;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = src=(?:\"|\')?(?<imgSrc>[^>]*[^/].(?:jpg|bmp|gif|png))(?:\"|\')?
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\u00B9\u008Esrc=-\u00A2png\'0\u00F3"
(define-fun Witness1 () String (seq.++ "\xb9" (seq.++ "\x8e" (seq.++ "s" (seq.++ "r" (seq.++ "c" (seq.++ "=" (seq.++ "-" (seq.++ "\xa2" (seq.++ "p" (seq.++ "n" (seq.++ "g" (seq.++ "'" (seq.++ "0" (seq.++ "\xf3" "")))))))))))))))
;witness2: "osrc=\'\u0091\u00AB\u00F1jpg"
(define-fun Witness2 () String (seq.++ "o" (seq.++ "s" (seq.++ "r" (seq.++ "c" (seq.++ "=" (seq.++ "'" (seq.++ "\x91" (seq.++ "\xab" (seq.++ "\xf1" (seq.++ "j" (seq.++ "p" (seq.++ "g" "")))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "s" (seq.++ "r" (seq.++ "c" (seq.++ "=" "")))))(re.++ (re.opt (re.union (re.range "\x22" "\x22") (re.range "'" "'")))(re.++ (re.++ (re.* (re.union (re.range "\x00" "=") (re.range "?" "\xff")))(re.++ (re.union (re.range "\x00" ".") (re.range "0" "\xff"))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (re.union (str.to_re (seq.++ "j" (seq.++ "p" (seq.++ "g" ""))))(re.union (str.to_re (seq.++ "b" (seq.++ "m" (seq.++ "p" ""))))(re.union (str.to_re (seq.++ "g" (seq.++ "i" (seq.++ "f" "")))) (str.to_re (seq.++ "p" (seq.++ "n" (seq.++ "g" "")))))))))) (re.opt (re.union (re.range "\x22" "\x22") (re.range "'" "'"))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
