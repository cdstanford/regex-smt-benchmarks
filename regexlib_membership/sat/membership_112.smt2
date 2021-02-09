;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = '/http:\/\/(?:www\.)?blip\.tv\/file\/(\d+).*/'
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\'/http://blip.tv/file/895B/\'"
(define-fun Witness1 () String (seq.++ "'" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "b" (seq.++ "l" (seq.++ "i" (seq.++ "p" (seq.++ "." (seq.++ "t" (seq.++ "v" (seq.++ "/" (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" (seq.++ "/" (seq.++ "8" (seq.++ "9" (seq.++ "5" (seq.++ "B" (seq.++ "/" (seq.++ "'" "")))))))))))))))))))))))))))))
;witness2: "b\u0095\u00C0\'/http://blip.tv/file/99\x1Ab/\'"
(define-fun Witness2 () String (seq.++ "b" (seq.++ "\x95" (seq.++ "\xc0" (seq.++ "'" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "b" (seq.++ "l" (seq.++ "i" (seq.++ "p" (seq.++ "." (seq.++ "t" (seq.++ "v" (seq.++ "/" (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" (seq.++ "/" (seq.++ "9" (seq.++ "9" (seq.++ "\x1a" (seq.++ "b" (seq.++ "/" (seq.++ "'" ""))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "'" (seq.++ "/" (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" ""))))))))))(re.++ (re.opt (str.to_re (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "." ""))))))(re.++ (str.to_re (seq.++ "b" (seq.++ "l" (seq.++ "i" (seq.++ "p" (seq.++ "." (seq.++ "t" (seq.++ "v" (seq.++ "/" (seq.++ "f" (seq.++ "i" (seq.++ "l" (seq.++ "e" (seq.++ "/" ""))))))))))))))(re.++ (re.+ (re.range "0" "9"))(re.++ (re.* (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (str.to_re (seq.++ "/" (seq.++ "'" ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
