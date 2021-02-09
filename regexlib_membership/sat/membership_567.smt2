;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <font[a-zA-Z0-9_\^\$\.\|\{\[\}\]\(\)\*\+\?\\~`!@#%&-=;:'",/\n\s]*>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "<font>"
(define-fun Witness1 () String (seq.++ "<" (seq.++ "f" (seq.++ "o" (seq.++ "n" (seq.++ "t" (seq.++ ">" "")))))))
;witness2: "x\u00BD<font>"
(define-fun Witness2 () String (seq.++ "x" (seq.++ "\xbd" (seq.++ "<" (seq.++ "f" (seq.++ "o" (seq.++ "n" (seq.++ "t" (seq.++ ">" "")))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "<" (seq.++ "f" (seq.++ "o" (seq.++ "n" (seq.++ "t" ""))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " "=")(re.union (re.range "?" "~")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))) (re.range ">" ">")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
