;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (?:(?:(?:http|ftp|gopher|telnet|news)://)(?:w{3}\.)?(?:[a-zA-Z0-9/;\?&=:\-_\$\+!\*'\(\|\\~\[\]#%\.])+)
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "ftp://www.pa:\u00B4"
(define-fun Witness1 () String (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." (seq.++ "p" (seq.++ "a" (seq.++ ":" (seq.++ "\xb4" "")))))))))))))))
;witness2: "oftp://-?\u00F7"
(define-fun Witness2 () String (seq.++ "o" (seq.++ "f" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "-" (seq.++ "?" (seq.++ "\xf7" "")))))))))))

(assert (= regexA (re.++ (re.union (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" "")))))(re.union (str.to_re (seq.++ "f" (seq.++ "t" (seq.++ "p" ""))))(re.union (str.to_re (seq.++ "g" (seq.++ "o" (seq.++ "p" (seq.++ "h" (seq.++ "e" (seq.++ "r" "")))))))(re.union (str.to_re (seq.++ "t" (seq.++ "e" (seq.++ "l" (seq.++ "n" (seq.++ "e" (seq.++ "t" ""))))))) (str.to_re (seq.++ "n" (seq.++ "e" (seq.++ "w" (seq.++ "s" "")))))))))(re.++ (str.to_re (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))(re.++ (re.opt (re.++ ((_ re.loop 3 3) (re.range "w" "w")) (re.range "." "."))) (re.+ (re.union (re.range "!" "!")(re.union (re.range "#" "(")(re.union (re.range "*" "+")(re.union (re.range "-" ";")(re.union (re.range "=" "=")(re.union (re.range "?" "?")(re.union (re.range "A" "]")(re.union (re.range "_" "_")(re.union (re.range "a" "z")(re.union (re.range "|" "|") (re.range "~" "~")))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
